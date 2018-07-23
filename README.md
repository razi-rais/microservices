
## Overview 
This repository contains content that will help you get started with building Microservices using Docker Containers, Kubernetes as technologies and Microsoft Azure as a platform.  

The strucure of the content is bit losse, but here is the list of artifacts availalbe. 

## Azure Kubernetes Service (AKS)

   + *[Part 1 - Introduction to the Historic Events Microservice](http://www.razibinrais.com/k8s-devops-part-1)*
  + *[Part 2 – Introduction to the Helm](http://www.razibinrais.com/k8s-devops-part-2)*  
  + *[Part 3 – VSTS Build - Build & Push Imagesto ACR and Building K8s artifacts](#)* : comming soon  
  + *[Part 4 – Deploying into AKS cluster using Helm and VSTS Release ](#)*: comming soon
  
 **What to download the source code?**
  
  [Download Sample Application (ASP.NET Core & Node.JS) - Histroic Events Microservice](https://github.com/razi-rais/aks-helm-sample)
 

## Azure Container Service (ACS)*

   + *[DevOps using Azure Container Service (DC/OS a  Swarm)](http://www.razibinrais.com/devops-with-containers)*

 **What to download the source code?**
 
[Download Sample Application - ASP.NET Core 2.0 UI + API](https://github.com/razi-rais/microservices/tree/master/education/containers/demos/webapp-webapi-aspnetcore)

*Microsoft is now recommeding AKS instead of ACS. If you are focusing on hybrid workloads or workloads that require customizations that are not supported by AKS, then you should look into [acs-engine](https://github.com/Azure/acs-engine).

## Artifacts

If you are new to Azure and wanted to quick start development with Docker containers and k8s, check out following Azure ARM templates/scripts. These resources will help you spend less time installing/setup components but rather using them to build/test your application.

### Azure - Linux Docker Developer Virtual Machine

Azure ARM template that creates Azure Linux VM with following software installed:

* Ubuntu Server 16.04 LTS
* Docker (includes docker engine, client and docker compose)
* Git
* Nodejs
* Dotnetcore 
* Azure Cli
* Yeoman
* Bower

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Frazi-rais%2Fmicroservices%2Fmaster%2Freference-material%2Farm-templates%2Fubuntu-1604LTS-docker.json" target="_blank">
    <img src="http://azuredeploy.net/deploybutton.png"/>
</a>
<a href="http://armviz.io/#/?load=https%3A%2F%2Fraw.githubusercontent.com%2Frazi-rais%2Fmicroservices%2Fmaster%2Freference-material%2Farm-templates%2Fubuntu-1604LTS-docker.json" target="_blank">
    <img src="http://armviz.io/visualizebutton.png"/>
</a>


After the virtual machine is created and running use the following command to find out versions of all of the installed software:

```
echo 'nodejs version ' $(node -v)  && echo 'npm version ' $(npm -v)  &&  echo 'dotnet version ' $(dotnet --version) && $(git --version) && az --version && printf "docker Client & Server version \n $(docker version)" 
```

### Azure - Windows Container Developer Virtual Machine

Azure ARM template that creates Azure Windows Server 2016 VM with following software installed:

* Windows Server 2016
* Windows Containers - Docker Engine and Docker Compose (NOTE: This template does not support Docker Linux containers running on Windows Server 2016. If you need both Docker Linux containers and Windows Containers use the ARM template below that install Docker for Windows - it does require nested virtualization)
* Chocolatey
* Putty
* Node 
* Dotnetcore
* Azure Cli
* Sql Server Management Studio (SMSS) 17
* Visual Studio Code
* Visual Studio 2017 Community Edition
  
<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Frazi-rais%2Fmicroservices%2Fmaster%2Freference-material%2Farm-templates%2Fwinsrv2016-docker.json" target="_blank">
    <img src="http://azuredeploy.net/deploybutton.png"/>
</a>
<a href="http://armviz.io/#/?load=https%3A%2F%2Fraw.githubusercontent.com%2Frazi-rais%2Fmicroservices%2Fmaster%2Freference-material%2Farm-templates%2Fwinsrv2016-docker.json" target="_blank">
    <img src="http://armviz.io/visualizebutton.png"/>
</a>

### Azure - Windows Container Developer Virtual Machine (with Docker for Windows)

Azure ARM template that creates Azure Windows Server 2016 VM with following software installed. Please 
note that Docker for Windows require nested virtualization. That is the reason behind using Standard_D2s_v3 
for this ARM template. 

* Windows Server 2016
* Docker for Windows - Docker Engine and Docker Compose (NOTE: This supports both Docker Linux containers and Windows containers. If you are looking for Windows containers only then use the ARM template above)
* Chocolatey
* Putty
* Node 
* Dotnetcore
* Azure Cli
* Sql Server Management Studio (SMSS) 17
* Visual Studio Code
* Visual Studio 2017 Community Edition
  
<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Frazi-rais%2Fmicroservices%2Fmaster%2Freference-material%2Farm-templates%2Fwin2016-vs2017-docker.json" target="_blank">
    <img src="http://azuredeploy.net/deploybutton.png"/>
</a>
<a href="http://armviz.io/#/?load=https%3A%2F%2Fraw.githubusercontent.com%2Frazi-rais%2Fmicroservices%2Fmaster%2Freference-material%2Farm-templates%2Fwin2016-vs2017-docker.json" target="_blank">
    <img src="http://armviz.io/visualizebutton.png"/>
</a>

### Scripts 
Various Bash and PowerShell scripts.

#### [Kubernetes Developer Machine (Ubuntu Server or Client 16.04 LTS)](https://github.com/razi-rais/microservices/blob/master/reference-material/install-k8s-lab-software.sh)

If you are working with K8s and Docker, use this script to have following software installed on your machine.

* Docker
* Minikube
* Kubectl
* Helm
* Azure CLI

#### [Stress Test CPU - Windows Containers](https://github.com/razi-rais/microservices/blob/master/reference-material/utility-scripts/Stress-TestCPUCores.ps1)

Simple script that help you stress test containers. You run the script on the host and pass the number of cores (e.g. ``` StressCPUCores.ps1 2``` ) and it will hit each core with 100% utlization. If you want to have all cores to reach 100% utlization then leave the parameter empty (e.g. ``` StressCPUCores.ps1``` -  Note: make sure you know what you are doing because script will choke the CPU and operating system may become non-responsive)

#### Stress Test Memory - Windows Containers
Simple one line command that will help you stress test the CPU memory. Please note that you need to download SysInternals utlity [testlimit64](https://live.sysinternals.com/windowsinternals/testlimit64.exe) first and make sure its available inside the running container.

``` 
//NOTE: In the command below, testlimit64.exe is available inside C:/Downloads/ directory on the host. 
//Also, -m switch limits the container memory usage to 1024 MB max. 

docker run -it -m 1024M -v C:/Downloads/:C:/utils/ microsoft/windowsservercore powershell

> C:\utils\testlimit64 -d -c 1024
```


#### [Open IE & Browse to Container IPAddress:Port](https://github.com/razi-rais/microservices/blob/master/reference-material/utility-scripts/Browse-ContainerByName.ps1)
Allows you to open IE automatically and browse to the Container IP Address and Port (default is 80). You need to pass valid container name. ```docker run --name``` swtich gives you ability to do that.  



