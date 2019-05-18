
# Kubernetes Workshop

This repository contains setup instructions and hands-on labs for the [Kubernetes Workshop](https://www.eventbrite.com/e/building-microservices-using-kubernetes-hands-on-workshop-online-attendence-option-available-tickets-61595687359).
This workshop is led by [Razi Rais](https://www.linkedin.com/in/razirais)

## Prerequisites 
> Approximate time to complete this task is 15 minutes

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

> Approximate time to complete this task is 15 minutes

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

> Since minikube is running inside a virtual machine it's really handy to reuse the Docker daemon inside that virtual machine; as this means you don't have to build on your host machine and push the image into a docker registry. All you need to do is run the command ```eval $(minikube docker-env)```. More details [here](https://github.com/kubernetes/minikube/blob/0c616a6b42b28a1aab8397f5a9061f8ebbd9f3d9/README.md#reusing-the-docker-daemon)


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

```
$ kubectl apply -f voting-app-front-svc.yaml 

$ kubectl get service voting-front
NAME           TYPE       CLUSTER-IP       EXTERNAL-IP   PORT(S)        AGE
voting-front   NodePort   10.102.202.223   <none>        80:32636/TCP   10s
```

```
$ minikube service voting-front --url
http://192.168.99.102:32636
```
![voting-app](./images/voting-app-1.png) 

```
kubectl get all -l env=dev
NAME                                    READY   STATUS    RESTARTS   AGE
pod/voting-app-backend-f77bd6f4-24757   1/1     Running   0          2m20s
pod/voting-app-front-596476c4c6-k4qlj   1/1     Running   0          2m20s

NAME                                 READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/voting-app-backend   1/1     1            1           2m20s
deployment.apps/voting-app-front     1/1     1            1           2m20s

NAME                                          DESIRED   CURRENT   READY   AGE
replicaset.apps/voting-app-backend-f77bd6f4   1         1         1       2m20s
replicaset.apps/voting-app-front-596476c4c6   1         1         1       2m20s
```

## Scaling the deloyment

> Approximate time to complete this task is 5 minutes
```
$ kubectl scale --replicas=2 deployment/voting-app-front

$ kubectl get po -l type=webapp 
```

## Rolling updates

> Approximate time to complete this task is 10 minutes

Change the title of the webapp from "Awesome Voting App" to "Awesome Voting App v2" by editing file ```config_file.cfg``` located inside ```/voting-app``` directory

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

```
$ eval $(minikube docker-env)

$ docker build -t voting-webapp:2.0 -f Dockerfile.voting-app .

$ kubectl apply -f voting-app-front-v2-dep.yaml 

$ kubectl rollout undo deployment/voting-app-front
```

![voting-app](./images/voting-app-2.png) 

## Performance monitoring using Grafana and Kubernetes Dashboard 

> Approximate time to complete this task is 10 minutes


For development purpose, I highly recommend enabling heapster add-on. Heapster enables multi-level monitoring and performance analysis including pods, nodes, and cluster.

Under the hood, it is using InfluxDB as the storage backend for metric data and Grafana as visualization UI.

> Approximate time to complete this task is 5 minutes

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

Either way you should able to land on the Grafana UI.

![grafana](./images/grafana-1.png) 

From the top pane select "Home" and then select "Pods".

![grafana](./images/grafana-2.png) 

You will be taken to a dashbord displaying various peformance related metrics like individual pod CPU, memory, network and filesystem usage. Change the namespace from ```kube-system``` to ```default``` and then select voting-front-app pod. The dashboard will update automatically to reflect the values related to the pod. 

![grafana](./images/grafana-3.png) 

## Explore Logs using EFK (Elasticsearch, Fluentd, Kibana)

```
$ kubectl logs pod_name

```
> Approximate time to complete this task is 15 minutes

This is powerful add-on consists of a combination of Elasticsearch, Fluentd and Kibana. Elasticsearch is a search engine that is responsible for storing our logs and allowing for them to be queried. Fluentd sends log messages from Kubernetes to Elasticsearch, whereas Kibana is a graphical interface for viewing and querying the logs stored in Elasticsearch.

> Note: This addon should not be used as-is in production. This is an example and you should treat it as such. Please see at least the Security and the Storage sections for more information.[here](https://github.com/kubernetes/kubernetes/tree/master/cluster/addons/fluentd-elasticsearch)

You start by enabling the EFK addon with minikube.
```
$ minikube addons enable efk
✅  efk was successfully enabled
```
It takes few seconds for all the pods related to efk to come up.
```
$ kubectl get po -n kube-system  -l "k8s-app in (fluentd-es,kibana-logging,elasticsearch-logging)"
NAME                          READY   STATUS    RESTARTS   AGE
elasticsearch-logging-rdq7p   1/1     Running   0          112m
fluentd-es-tlg5m              1/1     Running   0          112m
kibana-logging-4mh5f          1/1     Running   0          112m
```

> In the previous command you are filtering out the pods based on labels. It may seems advanced use case but its rather simple. Its a OR condition saying "give me all pods that have label ```k8s-app``` with one of the three values. This is helpful because we don't want to get everything that exists in ```kube-system``` namespace but rather focus on only the pods created by efk addons and have specefic labels. Learn more about use of labels [here](https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/)
 
The pod that gives us the dashboard UI to work the the logs is the one running Kibana. You can get to the dashboard in one of the two ways (first method is preferred)

```
$ minikube service kibana-logging --url -n kube-system
http://192.168.99.102:30003
```

```
$ kubectl port-forward kibana-logging-4mh5f 5601:5601 -n kube-system
Forwarding from 127.0.0.1:5601 -> 5601
Forwarding from [::1]:5601 -> 5601

```

Now open the browser and navigate to the URL pointing to the kibana endpoint (```http://192.168.99.102:30003``` or ```http://27.0.0.1:5601``` )

On the home page you need to configure an index pattern. By default there is none so you will go ahead and configure it now.

![kibana](./images/kibana-1.png) 

Select the option "I don't want to use the Time Filter" from the dropdown and then press "Create"

![kibana](./images/kibana-2.png) 

At this point you should see the main results pane with logs from the entire Kubernetes system. 

![kibana](./images/kibana-3.png) 

Kibana provides extensive features to work with logs by using all sorts of patterns etc. For now we will keep it simple and view the logs from the pod running voting-front webapp. But first you need to select the fields that makes the most sense and are useful to the results pane.

On the Available Fields pane select 
```kubernetes.pod_name , 	kubernetes.namespace_name, log and @timestamp  ``` fields. 

![kibana](./images/kibana-4.png) 

You will see the pane on the right side showing the results now have four columns added to it. Also, click on the ```@timestamp`` column to make it sort in decending order (latest logs first) 

![kibana](./images/kibana-5.png) 


Finally, you now filter the logs that are generated by voting-front-app pod. Make sure you have name of the pod copied (you can run ```kubectl get po ``` command again to get the name of the pod). Now, go back to the Kibana ui and select "Add a filter +" option. 

Create a new filter by using ```kubernetes.pod_name``` as the field name and use the name of the voting-front-app pod as the value. Your entry should looks similar to following:

![kibana](./images/kibana-6.png) 

Finally, press the "Save" button. 

Results pane should be updated to show the logs (latest first) generated by voting-front-app pod. 

![kibana](./images/kibana-7.png) 




