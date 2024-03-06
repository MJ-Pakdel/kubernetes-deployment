##  Kubernetes
* open source container orchestration tool
* the rise of small independent application called microservice is the reason kubernetes was found
* apps are made of hundres or thousands of containers. how to orchestrate them?
* it provides high availability or no downtime 
* scalability
* disaster recovery

### Kubernetes Architecture
* kubernetes cluster has at least one master node and couple of worker nodes. 
* each node has a kubelet process on it which allow workers to talk to each other
* each worker has one or few docker images running on it
* master has api server (to talk to you), controller manager(to manage workers), scheduler, etcd key value storage (has current state of each node and each container) so you can recover the whole cluster using spanshots that it creates
* in production you have at least two master node so if one die, you still manage your cluster
* pod is abstaction over container. usually one container or image per pod. however you can have several pods in the same worker. Pod is the smallest task in kubernetes
* you have one worker and two pod, one pod is your applicationa and the other pod is the database your application uses. kubernetes gives one ip address to app and one ip address to database. if your databse pod dies, a new pod will be created with a new ip address. so communication between different pods is impossible
* services allow to assign fixed ips address to each pod. so when pod dies, when it is back it is given the same ip address. you have one service per pod. when pod dies, service is still there
* ingress gets the request from the outside work (domain name) and send it to the service. rmemeber services have permanent numerical ips

### ConfigMap
### Kubernetes Secrets
