
# Kubernetes Workshop

This repository contains setup instructions and hands-on labs for the [Kubernetes Workshop](https://www.eventbrite.com/e/building-microservices-using-kubernetes-hands-on-workshop-online-attendence-option-available-tickets-61595687359).
This workshop is led by [Razi Rais](https://www.linkedin.com/in/razirais)

**In order to perfrom tasks in this workshop you're expected to have a working knowledge of Linux command line and basic understanding of Docker containers.**

## Prerequisites 
> Approximate time to complete this task is 20 minutes

 * Clone the repo: 
 ``` git clone  https://github.com/razi-rais/microservices.git && cd microservices/workshop  ```

> NOTE: Following software are compatiable with Linux, Mac OS X and Windows operating system. During the minikube setup you will need to install a hypervisor that will run the minikube vm. Recommendation is to use [virtualbox](https://www.virtualbox.org) as a hypervisor. 

* Install Docker (Stable Version) | [Mac](https://docs.docker.com/docker-for-mac/install/) | [Linux](https://docs.docker.com/install/) | [Windows](https://docs.docker.com/docker-for-windows/install/)

Verfiy the Docker installation:
```
$ docker version
Client: Docker Engine - Community
 Version:           18.09.2
 API version:       1.39
 Go version:        go1.10.8
 Git commit:        6247962
 Built:             Sun Feb 10 04:12:39 2019
 OS/Arch:           darwin/amd64
 Experimental:      false

Server: Docker Engine - Community
 Engine:
  Version:          18.09.2
  API version:      1.39 (minimum version 1.12)
  Go version:       go1.10.6
  Git commit:       6247962
  Built:            Sun Feb 10 04:13:06 2019
  OS/Arch:          linux/amd64
  Experimental:     false

```

In this training we will use [minikube](https://kubernetes.io/docs/getting-started-guides/minikube/) to run a local Kubernetes cluster. We will access this local Kubernetes cluster with the client tool  `kubectl`.

* Install [Minikube](https://kubernetes.io/docs/tasks/tools/install-minikube) (This link contains step by step insructions to setup Minikube on variety of operating systems)

* Install [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/) (This link contains step by step insructions to setup Minikube on variety of operating systems)


After successfull installation of minikube and kubectl verfiy the setup:
```
$ minikube version
minikube version: v1.0.1
```

Now, start the minikube. Please note that ```--vm-driver``` parameter is dependent on the type of hypervisor used during the minikube setup. Following example is using virtualbox as a hypervisor but you may need to change the value depending on your choice of the hypervisor as describe [here](https://kubernetes.io/docs/setup/minikube/#installation)

```
$ minikube minikube start --vm-driver=virtualbox

😄  minikube v1.0.1 on darwin (amd64)
🤹  Downloading Kubernetes v1.14.1 images in the background ...
💡  Tip: Use 'minikube start -p <name>' to create a new cluster, or 'minikube delete' to delete this one.
🔄  Restarting existing virtualbox VM for "minikube" ...
⌛  Waiting for SSH access ...
📶  "minikube" IP address is 192.168.99.102
🐳  Configuring Docker as the container runtime ...
🐳  Version of container runtime is 18.06.3-ce
⌛  Waiting for image downloads to complete ...
✨  Preparing Kubernetes environment ...
🚜  Pulling images required by Kubernetes v1.14.1 ...
🔄  Relaunching Kubernetes v1.14.1 using kubeadm ... 
⌛  Waiting for pods: apiserver proxy etcd scheduler controller dns
📯  Updating kube-proxy configuration ...
🤔  Verifying component health .....
💗  kubectl is now configured to use "minikube"
🏄  Done! Thank you for using minikube!

$ minikube status 

host: Running
kubelet: Running
apiserver: Running
kubectl: Correctly Configured: pointing to minikube-vm at 192.168.99.102

$ kubectl version

Client Version: version.Info{Major:"1", Minor:"14", GitVersion:"v1.14.1", GitCommit:"b7394102d6ef778017f2ca4046abbaa23b88c290", GitTreeState:"clean", BuildDate:"2019-04-19T22:12:47Z", GoVersion:"go1.12.4", Compiler:"gc", Platform:"darwin/amd64"}
Server Version: version.Info{Major:"1", Minor:"14", GitVersion:"v1.14.1", GitCommit:"b7394102d6ef778017f2ca4046abbaa23b88c290", GitTreeState:"clean", BuildDate:"2019-04-08T17:02:58Z", GoVersion:"go1.12.1", Compiler:"gc", Platform:"linux/amd64"}
```

You can take minikube to a test drive right away to make sure things are working as expected! Let us run a nginx server inside Kubernetes cluster.

> Note: Don't worry too much about Kubernetes objects like Pods, Deployment and Service. You will learn more about them in the next section when build and run a custom application.

```
$ kubectl run ngx --image=nginx --labels="type=webserver" 
```

Now run the command to see the pod running the nginx container.

```
$  kubectl get po -l type=webserver
NAME                   READY   STATUS    RESTARTS   AGE
ngx-5f48d9f7f5-xzxtz   1/1     Running   0          10s
```

Also, behind the scenes the run command created a Kubernetes deployment for you. 

```
$  kubectl get deployment ngx
NAME   READY   UP-TO-DATE   AVAILABLE   AGE
ngx    1/1     1            1           11s
```

Everthing is working as expected. Now you going to access the nginx using some form of a URL. After all its a webserver! In order to do that, first you need to expose the pod using the Kubernetes service. 

```
$ kubectl expose deployment ngx --type=NodePort --port=80 
```

Verify that service has been created successfully.
```
$kubectl get svc -l type=webserver -o wide
NAME   TYPE       CLUSTER-IP       EXTERNAL-IP   PORT(S)        AGE   SELECTOR
ngx    NodePort   10.106.191.246   <none>        80:32624/TCP   17s   type=webserver
```

With the service available you can get the URL to access the serice using an endpoint that will direct the traffic to the nginx pod!

```
$ minikube service ngx --url
http://192.168.99.102:32624
```
Now use curl/wget/browser to access the nginx.

```
$ curl $(minikube service ngx --url)

<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>
    body {
        width: 35em;
        margin: 0 auto;
        font-family: Tahoma, Verdana, Arial, sans-serif;
    }
</style>
</head>
<body>
<h1>Welcome to nginx!</h1>
<p>If you see this page, the nginx web server is successfully installed and
working. Further configuration is required.</p>

<p>For online documentation and support please refer to
<a href="http://nginx.org/">nginx.org</a>.<br/>
Commercial support is available at
<a href="http://nginx.com/">nginx.com</a>.</p>

<p><em>Thank you for using nginx.</em></p>
</body>
</html>
```

Alright, we got a webserver running but you may be wondering shouldn't there be a declarative way to define Pod, Deployment and Service? Perhaps using YAML or JSON format. That is a valid point and typically declarative style works better in most cases. It also aligns well with the "Infrastrucre as a Code" theme that is common in the DevOps community. For the rest of the lab you will be using YAML files to create Pods, Deployments, Services etc. You can learn more about the trade offs between imperative and declrative methods while working with Kubernetes objects [here](https://kubernetes.io/docs/concepts/overview/object-management-kubectl/imperative-command/#trade-offs)

To view to the YAML/JSON definition of the Kubernetes objects created in the previous steps you can use ```-o``` (output) swtich and get the definition of a particular object in ```YAML``` or in ```JSON``` format.

For example get the definition of deployment in YAML
```
$ kubectl get deployment ngx -o yaml

apiVersion: extensions/v1beta1
kind: Deployment
metadata:
  annotations:
    deployment.kubernetes.io/revision: "1"
  creationTimestamp: "2019-05-17T17:18:07Z"
  generation: 1
  labels:
    type: webserver
  name: ngx
  namespace: default
  resourceVersion: "101467"
  selfLink: /apis/extensions/v1beta1/namespaces/default/deployments/ngx
  uid: bcfc77dc-78c7-11e9-8278-08002732c767
.....(Output truncated for brevity)
```

## Build, Package, Deploy and Run a Multi-Container Application Using Kubernetes

> Approximate time to complete this task is 30 minutes

In this section you will build, package, deploy and run a multi-container application on a minikube Kubernetes locally. Later, you will learn how to scale and perform rolling updates to it. 

 
The voting application is a simple python web application that provides you with an option to vote for your favorite animal (cats or dogs). The voting results are store in a Redis cache which also acts as a backend.

The UI is shown below:
![voting-app](./images/voting-app-1.png) 
 
 You can review the code artifacts by browsing the directory: ```voting-app```. You can take a peek at it now but considering that its a very basic python code we won't spend time going into any details.

Let's focus on the Kubernetes artifacts and view them conceptually as they fit into Kubernetes architecture. 

#### Voting Application | Front End WebApp

Let's look at the bigger picture. Here is the story its tells --

 *End user sends a request to http://127.0.0.1:21516 endpoint to access the voting web app. Kubernetes voting service is running on a local minikube Kubernetes cluster that is listening to that endpoint. It acknowledge the request and check if any pod has labels that matches "type:webapp, env: dev". If there is a pod running with the matching labels service will route the request to it at port 80 (round robin technique is used to select the pod in case there are multiple pods).Pod accepts the request and route it to the container which is running the web application on port 80. Finally, web application process the request and send the reponse back.*

![voting-app-arch-1](./images/voting-app-arch-1.png)

If you look closely, right at the center you have a WebApp Container (packaged and running as a container). This is the python webapp that you will package as a Docker container shortly. The container itself resides in a pod. [Pod](https://kubernetes.io/docs/concepts/workloads/pods/pod) is a basic object iniside Kubernetes and unlike Docker you cannot run container without having a pod. Pod also allows you to add  miscellaneous pieces of information like labels to it. [Labels](https://kubernetes.io/docs/concepts/overview/working-with-objects/labels) help you to tag information to a pod (or even other type of Kubernetes objects) in a key/value format. We have labels ```type: webapp``` and ```env: dev``` assigned to the pod running the web app. Pods are usually defined inside a [Deployment](https://kubernetes.io/docs/concepts/workloads/controllers/deployment) to get the benefit of rolling updates and to ensure that you always have minimum number of pods running in the cluster. Behind the scenes deployment creates [ReplicaSet](https://kubernetes.io/docs/concepts/workloads/controllers/replicaset/) to ensure minimum number of pods are always running (you don't typically creates replicasets yourself so we don't discuss them in details)

You can review the contents of ```voting-app-front-dep.yaml ``` to get a sense of how pod, container, labels and replicas (minimum number of pods to run) are defined inside a deployment definition. Here is the list of most relevant items within the deployment yaml file.

| Type   |      Value      |  Details |
|----------|:-------------:|------:|
| name  | voting-app-front |  Name of the pod|
| labels |    env: dev , env: webapp   |   Labels associated with the pod|
| containers | image: voting-webapp:1.0 |   Container image name to run |
| containers | name: webfront | Mame of the container|

```
apiVersion: apps/v1beta1
kind: Deployment
metadata:
  name: voting-app-front
spec:
  replicas: 1
  strategy:
    rollingUpdate:
      maxSurge: 1
      maxUnavailable: 1
  minReadySeconds: 5 
  template:
    metadata:
      labels:
        env: dev
        type: webapp
    spec:
      nodeSelector:
        "beta.kubernetes.io/os": linux
      containers:
      - name: webfront
        image: voting-webapp:1.0
        imagePullPolicy: Never
        ports:
        - containerPort: 80
        resources:
          requests:
            cpu: 250m
          limits:
            cpu: 500m
        env:
        - name: REDIS
          value: "voting-backend"
```

Another important Kubernetes object is the [Service](https://kubernetes.io/docs/concepts/services-networking/service/). It is responsibe to route traffic to the correct/matching Pod. Our webapp runs on port 80 inside the pod. This is fine but as-is it won't be easily accessible to you because Kubernetes run a internal cluster network so IPs and access to it is not easy. This is where service comes into the picture. We are using service definition ```voting-app-front-svc.yaml ``` that tells Kubernetes to open a port on a Kubernetes node (which in this case is a minikube virtual machine). But how does services knows which Pod to route traffic to? It uses labels! This may sound strange at first but service has no direct ties to the pods at all. Its all losely coupled; a service selects a pod and route traffic to it based on the labels ```selector``` defined in the service definition file. In our case the labels are ``` type:webapp``` and ``` env:dev```. Also the ```type: NodePort``` means that Kubernetes will opens up a higher value port (typically in the range of 20000+) on the Node and listens on it for any incomming requets. Once it receives the request it routes it to the port 80 on a pod as defined by ```port:80``` within the ```ports``` section inside the service definition file.  

```
apiVersion: v1
kind: Service
metadata:
  name: voting-front
spec:
  type: NodePort
  ports:
  - port: 80
  selector:
    type: webapp
    env: dev
```

#### Voting Application | Backend 
The backend deployment definition ```voting-app-back-dep.yaml ``` defines a pod that runs a redis cache. It also assign labels ```type: database``` and ``` env: dev```  to the pod.  

![voting-app-arch-1](./images/voting-app-arch-2.png)

You can review the contents of ```voting-app-back-dep.yaml ``` to get a sense of how pod, container, labels and replicas are defined inside a deployment definition. Below is the summary of most releveant parts:

| Type   |      Value      |  Details |
|----------|:-------------:|------:|
| name  | voting-app-backend |  Name of the pod|
| labels |    env: dev , env: database   |   Labels associated with the pod|
| containers | image: redis |   Container image redis (available from Docker Hub) |
| containers | name: backend | Name of the container|

```
apiVersion: apps/v1beta1
kind: Deployment
metadata:
  name:  voting-app-backend
spec:
  replicas: 1
  template:
    metadata:
      labels:
        type: database 
        env: dev
    spec:
      nodeSelector:
        "beta.kubernetes.io/os": linux
      containers:
      - name: backend
        image: redis
        ports:
        - containerPort: 6379
          name: redis
```

We also have ```voting-app-back-svc.yaml ``` that defines the service to expose the redis cache. It is needed because voting front end webapp is running in a different pod and won't able to access it otherwise. Also note that unlike the front end service it does not expose the service as an enpoint on the Kubernetes Node. The reason is simple - we are not expecting any incoming requests from outside of Kubernetes cluster so better not to expose it.

```
apiVersion: v1
kind: Service
metadata:
  name: voting-backend
spec:
  ports:
  - port: 6379
  selector:
    type: database
    env: dev
```

#### Packaging Voting Application

You start by packaging voting web application as a container image. This is a simple webapp so Dockerfile is very basic as shown below. Dockerfile is using flask base image and then installs a redis python pacakge. Finally, we copy the code files residing inside the ```voting-app``` directory to the ```app``` directory inside the container image (it will be created automatically if not exists already).

````
FROM tiangolo/uwsgi-nginx-flask:python3.6
RUN pip install redis
ADD /voting-app /app
````

Next, build the container image:

```
$ docker build -t voting-webapp:1.0 -f Dockerfile.voting-app .

Sending build context to Docker daemon   42.5kB
Step 1/3 : FROM tiangolo/uwsgi-nginx-flask:python3.6
 ---> 80478e7b12fc
Step 2/3 : RUN pip install redis
 ---> Using cache
 ---> 7ae0710ee5d2
Step 3/3 : ADD /voting-app /app
 ---> Using cache
 ---> 626972034c28
Successfully built 626972034c28
Successfully tagged voting-webapp:1.0
```

> IMPORTTANT: Since minikube is running inside a virtual machine it's really handy to reuse the Docker daemon inside that virtual machine; as this means you don't have to build on your host machine and push the image into a docker registry. All you need to do is run the command ```eval $(minikube docker-env)```. More details [here](https://github.com/kubernetes/minikube/blob/0c616a6b42b28a1aab8397f5a9061f8ebbd9f3d9/README.md#reusing-the-docker-daemon)

That's it as far as building the container images for our voting app goes. Backend is just a redis cache and Docker Hub already has an [offfical Redis image](https://hub.docker.com/_/redis) for that so no need to build any more images.

#### Deploying Voting Application

We start with the backend. Simply because redis is used to store the voting results and without it voting web app won't work as expected.

The ```kubectl apply``` command is used to tell kubernetes to create a new deployment object as define in the ```voting-app-back-dep.yaml ``` file. 

```
$ kubectl apply -f voting-app-back-dep.yaml 
```

Verify the deployment was successful and pod is up and running.
```
$ kubectl get deployment voting-app-backend 
NAME                 READY   UP-TO-DATE   AVAILABLE   AGE
voting-app-backend   1/1     1            1           68s

$ kubectl get po -l type=database
NAME                                READY   STATUS    RESTARTS   AGE
voting-app-backend-f77bd6f4-f5gkd   1/1     Running   0          93s

```

Next, let us create the service so front-end web app can access the backend. Remember redis and webapp are running in two different pods and need to communicate via service endpoint. 

```
$ kubectl apply -f voting-app-back-svc.yaml 

$ kubectl get svc voting-backend 
NAME             TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)    AGE
voting-backend   ClusterIP   10.96.191.22   <none>        6379/TCP   41s
```

At this point the backend work is done. We can now begin deploying the front end webapp.

```
$ kubectl apply -f voting-app-front-dep.yaml 
```

Verify that the deplpoyment is successfull and pod is running.

```
$ kubectl get deployment voting-app-front
NAME               READY   UP-TO-DATE   AVAILABLE   AGE
voting-app-front   1/1     1            1           16m

$ kubectl get po -l type=webapp

NAME                                READY   STATUS    RESTARTS   AGE
voting-app-front-596476c4c6-6nqfj   1/1     Running   0          6m15s
```

Finally, deploy the voting front web app service.

```
$ kubectl apply -f voting-app-front-svc.yaml 

$ kubectl get service voting-front
NAME           TYPE       CLUSTER-IP       EXTERNAL-IP   PORT(S)        AGE
voting-front   NodePort   10.102.202.223   <none>        80:32636/TCP   10s
```

#### Testing Voting Application

You need to get the endpoint URL to access the voting app. This is exposed by the voting-front service. The easist way to get to it is by using ```minikube service``` command: 

```
$ minikube service voting-front --url
http://192.168.99.102:32636
```
Open the browser and navigate to the URL. You should see the UI as shown below. Voting app is now up and running! Go vote. 

![voting-app](./images/voting-app-1.png) 

## Scaling Deployment

> Approximate time to complete this task is 5 minutes

Currently, we only have a single pod running webapp container. In case there is more traffic comming in you may want to run mulitple pods to handle that traffic. This is done by scaling the deployment to run more pods. Kubernetes uses the concept of [ReplicaSet](https://kubernetes.io/docs/concepts/workloads/controllers/replicaset) to provide guarantee to always run minimun number of Pods. This is essentially the reson why you have single pod at the moment. If you open the ```voting-app-front-dep.yaml``` you will notice the entry  ```replicas:1```. This tell kubernetes to always run a single pod. If for some reason pod goes down Kuberentes will run a new pod to bring the replica count to ```1```. 

Scaling to muliptle replicas can be done using ```kubectl scale``` command. ```---replicas``` swtich defines how many pods you like to run. Run the command to increase the replica count for the voting-front app to ```2```. You can also scale back to one pods as/if needed by running the command again with ```replicas=1```.

```
$ kubectl scale --replicas=2 deployment/voting-app-front
deployment.extensions/voting-app-front scaled

$ kubectl get po -l type=webapp 
NAME                                READY   STATUS    RESTARTS   AGE
voting-app-front-5f869574b7-lk6mr   1/1     Running   0          35h
voting-app-front-5f869574b7-wk8rl   1/1     Running   0          20s
```

## Perfrom Rolling Updates and Rollback to Voting Application

> Approximate time to complete this task is 10 minutes

Let's make a minor change to the voting front web app and see how we can deploy the application again without downtime!

Begin by changing the title of the webapp from "Awesome Voting App" to "Awesome Voting App v2" by editing the ```config_file.cfg``` file located inside ```/voting-app``` directory.

**Before | config_file.cfg**
```
# UI Configurations
TITLE = 'Awesome Voting App'
VOTE1VALUE = 'Cats'
VOTE2VALUE = 'Dogs'
SHOWHOST = 'false' 
```

**After | config_file.cfg**
```
# UI Configurations
TITLE = 'Awesome Voting App v2'
VOTE1VALUE = 'Cats'
VOTE2VALUE = 'Dogs'
SHOWHOST = 'false'
```

Currently we are running ```1.0``` version of the web app as reflected by the tag field of the container image ```voting-webapp:1.0```. After the updates you build the container again with an updated tag ```voting-webapp:2.0```.

```
$ eval $(minikube docker-env)

$ docker build -t voting-webapp:2.0 -f Dockerfile.voting-app .
```

You have the new webapp container image ready. The ```voting-app-front-v2-dep.yaml``` is a new deployment file which is identical to the one that is currently deployed except that it has an image field set to the new container image ```image: voting-webapp:2.0```. 

```
apiVersion: apps/v1beta1
kind: Deployment
metadata:
  name: voting-app-front
spec:
  replicas: 1
  strategy:
    rollingUpdate:
      maxSurge: 1
      maxUnavailable: 1
  minReadySeconds: 5 
  template:
    metadata:
      labels:
        env: dev
        type: webapp
    spec:
      nodeSelector:
        "beta.kubernetes.io/os": linux
      containers:
      - name: webfront
        image: voting-webapp:2.0
.......(Output truncated for brevity)
```

Also, its important to highlight the ```strategy``` section in the deployment file. Basically the ```rollingUpdate``` is a type of update stragey which specify ```maxUnavailable``` and ```maxSurge``` to control the rolling update process. The  ```maxUnavailable``` specifies the maximum number of Pods that can be unavailable during the update process and it is set to ```1``` meaning only single pod can be down at any point in time during the update process. Also, ```maxSurge``` specifies the maximum number of Pods that can be created over the desired number of Pods and currently it is set to ```1``` which means only single pod will be added at a time. In a nutshell with this definition we always have at least one pod running making sure that any in comming traffic don't get disrupted. You can learn more about various options available for the strategy [here](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/#strategy)

Its time to go head and perfrom the rolling update!

```
$ kubectl apply -f voting-app-front-v2-dep.yaml 
```

Refresh the voting web app and you should see the updates in action.

![voting-app](./images/voting-app-2.png) 

Although the deployed webapp with an update seems to be working fine we are now going to roll it back to the last version ```1.0```. This is useful when things don't go according to plan. Rolling back is simple; you basically point out to the deployment and use the ```rollout``` command with the ```undo``` parameter. This will revert the deployment back from ```voting-webapp:2.0``` to the previous version ```voting-webapp:1.0```.

```
$ kubectl rollout undo deployment/voting-app-front
```

## Performance Monitoring & Visualization Using Grafana and Kubernetes Dashboard 

> Approximate time to complete this task is 10 minutes

### Grafana

To view the performace monitoring metrics in Kubernetes, Grafana provides a popular visualization dashboard. This is done by enabling Heapster addon which provides multi-level monitoring and performance analysis including pods, nodes, and cluster. Behind the scenes, it leverages InfluxDB as the storage backend for metric data and Grafana as visualization UI.

> Note: Minikube provides you with the built in addons that can be enabled,disabled, and opened inside of the local Kubernetes environment. They provide a convenient way to enable or disable features in your Kubernetes envrioment. You can find more details about addons [here](https://github.com/kubernetes/minikube/blob/master/docs/addons.md) 

You start by enabling the heapster addon:

```
$ minikube addons enable heapster
✅  heapster was successfully enabled
```

Once the addon is installed you can access the Grafana UI using one of the following commands:

Option-1
```
$ minikube addons open heapster
```

Option-2
Use the URL of the service endpoint to access the Grafana UI.
```
$ minikube service monitoring-grafana --url -n=kube-system
http://192.168.99.102:30002
```

> Note: ```kube-system``` is a type of Kubernetes namespace. Namespace provide a scope for names. Names of resources need to be unique within a namespace, but not across namespaces. You can think of them as way to isolate resources. The ```kube-system``` namespace contains Pods,Deployments etc that are used by the Kubernetes system itself. Everything you define by default goes to a ```default``` namespace. You can read more about namespaces [here](https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces)

Either way you should able to land on the Grafana UI.

![grafana](./images/grafana-1.png) 

From the top pane select "Home" and then select "Pods".

![grafana](./images/grafana-2.png) 

You will be taken to a dashbord displaying various peformance related metrics like individual pods' CPU, memory, network and filesystem usage. Change the namespace from ```kube-system``` to ```default``` and then select voting-front-app pod from the pod-name dropdown. The dashboard will update automatically to reflect the values related to the pod. 

![grafana](./images/grafana-3.png) 

That's it for now. You can learn more about Grafana capabilites [here](https://grafana.com). Typically, you leverage [Promethous](http://prometheus.io/) through its [Kubernetes operator](https://github.com/kubernetes/kubernetes/tree/master/cluster/addons/prometheus) to act as an input source for Grafana to build powerful dashboards. We will leave it for now but you can learn about setting it up [here](https://github.com/giantswarm/prometheus) and view some advanced Grafana dashboard [here](https://grafana.com/dashboards?search=kubernetes).

### Kubernetes Dashboard

Kubernetes has a build in UI [dashboard](https://github.com/kubernetes/dashboard) that acts a swiss army knife to manage the Kubernetes clusters.

You can enable it by using the addons option in the minikube:

```
$ minikube addons enable dashboard
✅  dashboard was successfully enabled
```

Open the dashboard:

```
$ minikube addons open dashboard
```
![k8s-dashboard](./images/k8s-dashboard-1.png) 

> NOTE: If for some reason you don't see the dasboard opening up in the browser then use ```port-forwarding``` command shown below. 

First capture the name of the pod running the dashboard application. 

```
$ kubectl get po -n kube-system -l "app=kubernetes-dashboard"  
NAME                                    READY   STATUS    RESTARTS   AGE
kubernetes-dashboard-79dd6bfc48-4c527   1/1     Running   4          8d
```
Now start port-forwarding traffice to that pod.

```
$ kubectl port-forward kubernetes-dashboard-79dd6bfc48-4c527 -n kube-system 9090:9090
Forwarding from 127.0.0.1:9090 -> 9090
Forwarding from [::1]:9090 -> 9090
```
Now, open the browser and navigate to the dashboard using the URL: ```http://127.0.0.1:9090```.


## Explore Logging

> Approximate time to complete this task is 15 minutes

#### Working with kubectl logs command  
Without any extra addons you can simply get to the logs generated by the container running inside the pod by using the```kubectl logs``` command. Basically, anything that container outputs to STDOUT and STDERR is available as part of the logs.

Lets check the logs of voting front web app.

```
$ kubectl get pod -l type=webapp
NAME                                READY   STATUS    RESTARTS   AGE
voting-app-front-5f869574b7-lk6mr   1/1     Running   0          38h

$ kubectl logs voting-app-front-5f869574b7-lk6mr

172.17.0.1 - - [18/May/2019:18:44:05 +0000] "POST / HTTP/1.1" 200 961 "http://192.168.99.102:32516/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_4) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/12.1 Safari/605.1.15" "-"
[pid: 15|app: 0|req: 21/31] 172.17.0.1 () {50 vars in 879 bytes} [Sat May 18 18:44:05 2019] POST / => generated 961 bytes in 2 msecs (HTTP/1.1 200) 2 headers in 80 bytes (1 switches on core 0)
172.17.0.1 - - [18/May/2019:18:44:05 +0000] "POST / HTTP/1.1" 200 961 "http://192.168.99.102:32516/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_4) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/12.1 Safari/605.1.15" "-"
.....(Output truncated for brevity)
```

You can also use ```-f``` swtich with the logs command to keep getting live updates from the logs. 

The logs commands is very helpul but you may want to go beyond it when working with a large scale system. [EFK](https://github.com/kubernetes/kubernetes/tree/master/cluster/addons/fluentd-elasticsearch) is a powerful add-on consists of a combination of Elasticsearch, Fluentd and Kibana. Elasticsearch is a search engine that is responsible for storing our logs and allowing for them to be queried. Fluentd sends log messages from Kubernetes to Elasticsearch, whereas Kibana is a graphical interface for viewing and querying the logs stored in Elasticsearch.

> Note: This addon should not be used as-is in production. This is an example and you should treat it as such. Please see at least the Security and the Storage sections [here](https://github.com/kubernetes/kubernetes/tree/master/cluster/addons/fluentd-elasticsearch)

You start by enabling the EFK addon:  
```
$ minikube addons enable efk
✅  efk was successfully enabled
```
It may takes few seconds for all of the pods related to the efk to come up. You can check their status by running the command:

```
$ kubectl get po -n kube-system  -l "k8s-app in (fluentd-es,kibana-logging,elasticsearch-logging)"
NAME                          READY   STATUS    RESTARTS   AGE
elasticsearch-logging-rdq7p   1/1     Running   0          112m
fluentd-es-tlg5m              1/1     Running   0          112m
kibana-logging-4mh5f          1/1     Running   0          112m
```

> In the previous command you are filtering out the pods based on labels. It may seems advanced use case but its rather simple. Its a OR condition saying "give me all pods that have label ```k8s-app``` with one of the three values. This is helpful because we don't want to get everything that exists in ```kube-system``` namespace but rather focus on only the pods created by efk addons and have specefic labels. Learn more about use of labels [here](https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/)
 
The pod that gives us the dashboard UI to work with the logs is the one running Kibana. You can get to the dashboard in one of the two ways (first method is preferred)

Option 1:
```
$ minikube service kibana-logging --url -n kube-system
http://192.168.99.102:30003
```
Option 2:
```
$ kubectl port-forward kibana-logging-4mh5f 5601:5601 -n kube-system
Forwarding from 127.0.0.1:5601 -> 5601
Forwarding from [::1]:5601 -> 5601

```

Now open the browser and navigate to the URL that points to the kibana endpoint (```http://192.168.99.102:30003``` or ```http://27.0.0.1:5601``` )

On the home page, first you need to configure an index pattern. By default there is none so you will go ahead and configure it now.

![kibana](./images/kibana-1.png) 

Select the option "I don't want to use the Time Filter" from the dropdown and then press "Create"

![kibana](./images/kibana-2.png) 

At this point you should see the main results pane with logs from the entire Kubernetes system. 

![kibana](./images/kibana-3.png) 

Kibana provides extensive features to work with logs by using all sorts of patterns etc. For now we will keep it simple and view the logs from the pod running voting-front webapp. But first you need to select the fields that makes the most sense and add them to the results pane on the right.

On the "Available Fields pane select" 
```kubernetes.pod_name , 	kubernetes.namespace_name, log and @timestamp  ``` fields. 

![kibana](./images/kibana-4.png) 

You should see the results pane on the right with four columns added to it. Also, click on the ```@timestamp``` column to make it sort the entries in the decending order (latest logs first) 

![kibana](./images/kibana-5.png) 


Finally, you are ready to filter the logs that are generated by voting-front-app pod. Make sure you have name of the pod copied (you can run ```kubectl get po ``` command again to get the name of the pod). 

From Kibana UI select "Add a filter +" option available on the top pane. 

Create a new filter by using ```kubernetes.pod_name``` as the field name and use the name of the voting-front-app pod for the value. Your entry should looks similar to following:

![kibana](./images/kibana-6.png) 

Finally, press the "Save" button. 

Results pane should be updated to show the logs (latest first) generated by the voting-front-app pod. 

![kibana](./images/kibana-7.png) 
 




