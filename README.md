# Microservices - Education & Lessons Learned from the Field 
  

This repository contains the content that can help you develop skills on Microservices. The content is divided into education which is in the form of hands-on lab and guidance which in the form of reference material based on the real world experiences while working on projects.  

The hands-on labs are divided into two technologies - containers and service fabric and are highly modular. You can choose if you like to focus on one technology vertical or more. For example, you can focus on both Containers and Microsoft Service Fabric but can also decide to focus on either of them. Labs are also kept with minimum dependencies among themselves however some basic level software installation / subscription will of course be needed which will be explained in detail in the first module.


All the content is distributed into a folder structure as follows:

+ *Education*

  + *Containers:*  All content in this folder is related to containers including labs and supporting documents. 

  + *Service-Fabric:* All content in this folder is related to Microsoft Service Fabric including labs and supporting documents. 

+ *Reference-Material:* Contains content related to architecture, design and implementation of Microservices but mainly driven by experiences and lesson learned from the field. This also means that content is spread across broad range of topics. For example, design consideration for building Microservices on Azure platform (Containers and Service Fabric) versus how to implement mutual TLS in a Docker Swarm cluster.
 

##Microservices   
1.	Overview and Motivation behind Microservices 
2.	Monolithic, SOA and Microservices 
3.	Service Discovery Pattern
4.	API Gateway Pattern
5.	Single Service Per Host Pattern
6.	Message Broker Pattern
7.	CQRS Pattern 
8.	Versioning

##Containers 
###Foundation 

+ Setup The Lab Environment (Windows OS & Linux OS)
2. Docker Linux and Windows Containers (including Hyper-V) Overview 
3. Building and Running First Container (Windows Container & Linux Container)  
+ Using CLI and PowerShell to work with Docker  
4. Packaging Application into Container Images   
5. Publishing Container Image to Public Registry  
6. Shared & Persistent Storage with Volumes
7. Using Visual Studio 2015 to Build Containers 
7. Getting Started with Azure Container Service 

###Intermediate

+	Understanding CI/CD with Containers 
2.	Blue-Green Deployments and Containers 
3.	Clustering & Orchestration Tools Overview 
4.	Building Apache Mesos Cluster Using Azure Container Service 
5.	Building Docker Swarm Cluster Using Azure Container Service 


##Service Fabric

###Foundation 
+ Setup The Lab Environment 
+ Understanding Stateful & Stateless Services 
+ Building Stateless Service Using Service Fabric 
+ Building Stateful Service Using Service Fabric 
+ Packaging & Deploying Application to Service Fabric Cluster 
