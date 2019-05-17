
# Kubernetes Workshop

This repository contains setup instructions and hands-on labs for the [Kubernetes Workshop](https://www.eventbrite.com/e/building-microservices-using-kubernetes-hands-on-workshop-online-attendence-option-available-tickets-61595687359).
This workshop is led by [Razi Rais](https://www.linkedin.com/in/razirais)

## Prerequisites 
> Approximate time to complete this section is 10 minutes

In this training we will use [minikube](https://kubernetes.io/docs/getting-started-guides/minikube/) to run a local Kubernetes cluster. We will access this local Kubernetes cluster with the client tool  `kubectl`.

> NOTE: Following software are compatiable with Linux, Mac OS X and Windows operating system. During the minikube setup you will need to install a hypervisor that will run the minikube vm. It is reocmmended to use virtualbox as a hypervisor if possible. 

* Clone the repo:  ``` git clone  https://github.com/razi-rais/microservices.git && cd microservices/workshop  ```
* Install [Minikube](https://kubernetes.io/docs/tasks/tools/install-minikube) (This link contains step by step insructions to setup Minikube on variety of operating system)
* Install [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/) (This link contains step by step insructions to setup Minikube on variety of operating systems)


After successfull installation of minikube and kubectl verfiy the setup:
```
$ minikube version
minikube version: v1.0.1
```

Now, start the minikube. Please note that ```--vm-driver``` parameter is dependent on the type of hypervisor used during the minikube setup. Following example is using virtualbox as a hypervisor but you may need to change the value depending on your choice of the hypervisor.

```
$ minikube minikube start --vm-driver=virtualbox

😄  minikube v1.0.1 on darwin (amd64)
🤹  Downloading Kubernetes v1.14.1 images in the background ...
💡  Tip: Use 'minikube start -p <name>' to create a new cluster, or 'minikube delete' to delete this one.
🏃  Re-using the currently running virtualbox VM for "minikube" ...
⌛  Waiting for SSH access ...
📶  "minikube" IP address is 192.168.99.102
🐳  Configuring Docker as the container runtime ...
🐳  Version of container runtime is 18.06.3-ce
⌛  Waiting for image downloads to complete ...
✨  Preparing Kubernetes environment ...

$ minikube status 

host: Running
kubelet: Running
apiserver: Running
kubectl: Correctly Configured: pointing to minikube-vm at 192.168.99.102

$ kubectl version

Client Version: version.Info{Major:"1", Minor:"14", GitVersion:"v1.14.1", GitCommit:"b7394102d6ef778017f2ca4046abbaa23b88c290", GitTreeState:"clean", BuildDate:"2019-04-19T22:12:47Z", GoVersion:"go1.12.4", Compiler:"gc", Platform:"darwin/amd64"}
Server Version: version.Info{Major:"1", Minor:"14", GitVersion:"v1.14.1", GitCommit:"b7394102d6ef778017f2ca4046abbaa23b88c290", GitTreeState:"clean", BuildDate:"2019-04-08T17:02:58Z", GoVersion:"go1.12.1", Compiler:"gc", Platform:"linux/amd64"}
```

You can take minikube to a test drive right away to make sure things are working as expected! Let us run a nginx server in a kubernetes way.

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

Alright, that was good but you may be wondering shouldn't there be a declarative way to define Pod, Deployment and Service? Perhaps using YAML or JSON format. That is a valid point and typically declarative style works better in most cases. It also aligns well with the "Infrastrucre as a Code" theme that is common in the DevOps community. For the reminder of the labs you will be using YAML files to create Pods, Deployments, Services etc. You can learn more about the trade offs between imperative and declrative methods while working with Kubernetes objects [here](https://kubernetes.io/docs/concepts/overview/object-management-kubectl/imperative-command/#trade-offs)

To view to the YAML/JSON definition of the Kubernetes objects created in previous steps you can use -o (output) swtich and get the definition of a particular object in YAML or in JSON format.

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

## Build, Package, Deploy and Run a multi-container application with Kubernetes

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

We start with the backend. Redis is used to store the of the voting.

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

Next, let us create the service so front-end web app can access the backend (we will deploy it soon). Remember database and webapp are running in two different pods and need to communicate via service endpoint. 

```
$ kubectl apply -f voting-app-back-svc.yaml 

$ kubectl get svc voting-backend 
NAME             TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)    AGE
voting-backend   ClusterIP   10.96.191.22   <none>        6379/TCP   41s
```




The next step is to create the deployment that contains the pod definition.  

```
$ kubectl apply -f voting-app-front-dep.yaml 
```

This will bring the voting-app pod up. 

```
$ kubectl get po -l type=webapp

NAME                                READY   STATUS    RESTARTS   AGE
voting-app-front-596476c4c6-6nqfj   1/1     Running   0          6m15s
```




> Since minikube is running inside a virtual machine it's really handy to reuse the Docker daemon inside that virtual machine; as this means you don't have to build on your host machine and push the image into a docker registry. All you need to do is run the command ```eval $(minikube docker-env)```. More details [here](https://github.com/kubernetes/minikube/blob/0c616a6b42b28a1aab8397f5a9061f8ebbd9f3d9/README.md#reusing-the-docker-daemon)
