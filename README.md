# Learn Terraform - Provision an EKS Cluster

This repo is a companion repo to the [Provision an EKS Cluster tutorial](https://developer.hashicorp.com/terraform/tutorials/kubernetes/eks), containing
Terraform configuration files to provision an EKS cluster on AWS.

##  Kubernetes
* open source container orchestration tool
* the rise of small independent application called microservice is the reason kubernetes was found
* apps are made of hundres or thousands of containers. how to orchestrate them?
* it provides high availability or no downtime 
* scalability
* disaster recovery

## Kubernetes Architecture
### Pod
* kubernetes cluster has at least one master node and couple of worker nodes. 
* in production you have at least two master node so if one die, you still manage your cluster
* master has api server (to talk to you), controller manager(to manage workers), scheduler, etcd key value storage (has current state of each node and each container) so you can recover the whole cluster using spanshots that it creates
* it cd holds the current status of any kubernetes component at any time. 
* each node worker has a kubelet process on it which allow workers to talk to each other
* each worker has one or few pods images running on it
* pod is abstaction over container. usually one container or image per pod. Pod is the smallest task in kubernetes
* For example, you have one worker and two pod, one pod is your applicationa and the other pod is the database your application uses. kubernetes gives one ip address to app and one ip address to database. if your databse pod dies, a new pod will be created with a new ip address. so communication between different pods is impossible
### Service
* services allow to assign fixed ips address to each pod. so when pod dies, when it is back it is given the same ip address. you have one service per pod. when pod dies, service is still there. it is an internal load balancer and ensures that a deployed application is accessible to other applications or external users. It provides a single point of entry for accessing one or more Pods. even when the pod dies, the service is there
### Volume
* it allows you to store and manage data in your containers,related to your application. it is not like etcdkey that is data related to the status of the kuebernetes cluster. when you define your pod, you can make volume either local disk (disk of your worker node), or it could persistent volume if your application needs that data to store somewhere permanently. The problem of persisten volume is latency. kubernetes does not manage data storage. you have to do it
### Ingress
* For you application to get internet from the internet, you create an external service, but for your database that is not going to be reached from the internet, you create internal service. The problem with external service web adress is that there is an ip number and port number in it. This is where ingress comes. Request from the outside world goes to the ingress first, and then ingress send it to the external service attached to the application pod. So ingress route traffic into the cluster

### ConfigMap and Secret
You want to decouple your configuration from the application.if you want to change your database from mogodb to dynamodb, or you change your user and pass, you dont want to rebuild your images. 

apiVersion: v1
kind: ConfigMap
metadata:
  name: example-configmap
data:
  application.properties: |
    property1=value1
    property2=value2
  loglevel: "INFO"


apiVersion: v1
kind: Pod
metadata:
  name: example-pod
spec:
  containers:
    - name: example-container
      image: example-image
      volumeMounts:
      - name: config-volume
        mountPath: /etc/config
      env:
        - name: LOG_LEVEL
          valueFrom:
            configMapKeyRef:
              name: example-configmap
              key: loglevel
  volumes:
    - name: config-volume
      configMap:
        name: example-configmap
        items:
        - key: "application.properties"
          path: "application.properties"

you save passwords in secret. You connect your secret to pod

### Deployment:
* in practice you are not mostly dealing with pods. You deal with deployment. in Deployment, you have a blueprint for pod and then you say how many of that pod you want, and kubernetes makes sure to create as many pod as necessary based on your blueprint. 
### Stateful Set
You can replicate your application pod through deployment because application pod is stateless but you cannot replicate your database pod through deployment since database is stateful. For databases like mongodb, elastic search, etc should be set through stateful set and not deployment. Stateful set basically does the same thing that deployment does to scale up or down pods but it makes sure that data is synchronized.so different databases on different pods are consistent

## Best Practice:
deployment file is best to be place in your application repo. 
