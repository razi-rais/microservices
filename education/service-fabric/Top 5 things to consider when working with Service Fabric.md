## As you consider using Service Fabric platform for Microservices development, I have found that having the following knowledge is essential to consider.   
### One should have familiarity with characteristics of Microservices agnostic of the technology or platform, including general familiarity with Microservices characteristics and design patterns 

1. **Autonomous**: A self-contained unit of functionality with loosely coupled dependencies on other services. 
2. **Isolated**: A unit of deployment that can be modified, tested and deployed as a unit without impacting other areas of a solutionElastic: Microservices are designed to be stateful or stateless and can be scaled independently of other services. 
3. **Resilient**: Fault tolerant and highly available. 
4. **Responsive**: Services that respond to requests in a reasonable amount of time. 
5. **Message Oriented**: Services that rely on synchronous or asynchronous message-passing to establish a boundary between components 
6. **Configurable**: Services that provide an API and/or a console that provides access to administrative operations. 
7. **Automated**: Services whose lifecycle is managed through automation that includes development, build, test, staging, production and distribution. 
8. **Programmable**: Services that provide API’s for access by developers and administrators and applications are composed from multiple microservices.   

### General familiarity with common Design Patterns used in Microservices is also very helpful
1. **Service Discovery** 
2. **BoundedContext**
3. **ResilienceAPI** 
4. **API Gateway**
5. **Monitoring**
6. **Feature Flags** 
7. **CQRS**
8. **Consumer-Driven Contract** 
9. **Event Sourcing** 

### Evaluate your platform needs. App Service vs Service Fabric, is microservices the right approach for your specific project/uses cases
1. Hyper scale can only be achieved with SF, not App Service. The yellow highlights show comparison between the two platforms on deployments, scaling, and patching.
2. Also worth noting is that Windows Servers in the Cluster do not support IIS on the servers.
3. Choose the technology stack to implement your Microservices.

### Platform Comparison

| Feature        | App Service (Web Apps) | Cloud Services (Web Roles)  | Virtual Machines | Service Fabric | Notes |
| ------------- |:-------------:| -----:|-----:|-----:|--------------------:|
| Near-instant deployment| Yes | No | No | Yes | Deploying an application or an application update to a Cloud Service, or creating a VM, takes several minutes at least; deploying an application to a web app takes seconds. |
| Scale up to larger machines without redeploy      | Yes      | No |   No |  Yes |  |
| Web server instances share content and configuration, which means you don't have to redeploy or reconfigure as you scale. | Yes      |    No | No | Yes |  |
| Multiple
deployment environments (production and staging)      | Yes      | Yes |   No | Yes | Service Fabric allows you to have multiple environments for your apps or to deploy different versions of your app side-by-side. |
| Automatic OS update management      | Yes      | Yes |   No | No | Automatic OS updates are planned for a future Service Fabric release. |
| Seamless platform switching (easily move between 32 bit and 64 bit)      | Yes      | Yes |   No | No |  |
| Deploy code with GIT, FTP      | Yes      | No |   Yes | No |  |
| Deploy code with Web Deploy      | Yes      | No |   Yes | No | Cloud Services supports the use of Web Deploy to deploy updates to individual role instances. However, you can't use it for initial deployment of a role, and if you use Web Deploy for an update you have to deploy separately to each instance of a role. Multiple instances are required in order to qualify for the Cloud Service SLA for production environments. |
| WebMatrix support      | Yes      | No |   Yes | No |  |
| Access to services like Service Bus, Storage, SQL Database      | Yes      | Yes |   Yes | Yes |  |
| Host web or web services tier of a multi-tier architecture      | Yes      | Yes |   Yes | Yes |  |
| Host middle tier of a multi-tier architecture      | Yes      | Yes |   Yes | Yes | App Service web apps can easily host a REST APImiddle tier, and the WebJobs feature can host background processing jobs. You can run [WebJobs](http://go.microsoft.com/fwlink/?linkid=390226) in a dedicated website to achieve independent scalability for the tier. The preview [API apps](https://azure.microsoft.com/en-us/documentation/articles/app-service-api-apps-why-best-platform/) feature provides even more features for hosting REST services. |
| Integrated MySQL-as-a-service support      | Yes      | Yes |   Yes | No | Cloud Services can integrate MySQL-as-a-service through ClearDB's offerings, but not as part of the Azure Portal workflow. |
| Support for ASP.NET, classic ASP, Node.js, PHP, Python      | Yes      | Yes |   Yes | Yes | Service Fabric supports the creation of a web front-end using ASP.NET 5 or you can deploy any type of application (Node.js, Java, etc) as a guest executable. |
| Scale out to multiple instances without redeploy      | Yes      | Yes |   Yes | Yes | Virtual Machines can scale out to multiple instances, but the services running on them must be written to handle this scale-out.  |
| Support for SSL      | Yes      | Yes |   Yes | Yes | For App Service web apps, SSL for custom domain names is only supported for Basic and Standard mode. For information about using SSL with web apps, see [Configuring an SSL](https://azure.microsoft.com/en-us/documentation/articles/web-sites-configure-ssl-certificate/) certificate for an Azure Website. |
| Visual Studio integration      | Yes      | Yes |   Yes | Yes |  |
| Remote Debugging      | Yes      | Yes |   Yes | No |  |
| Deploy Code with TFS      | Yes      | Yes |   Yes | Yes |  |
| Network isolation with Azure Virtual Network      | Yes      | Yes |   Yes | Yes |  |
| Support for Azure Traffic Manager      | Yes      | Yes |   Yes | Yes |  |
| Integrated Endpoint Monitoring      | Yes      | Yes |   Yes | No |  |
| Install any custom MSI      | No      | Yes |   Yes | Yes | Service Fabric allows you to host any executable file as a guest executable or you can install any app on the VMs. |
| Ability to define/execute start-up tasks      | No      | Yes |   Yes | Yes |  |
| Can Listen to ETW events      | No      | Yes |   Yes | Yes |  |

### Automation is not an option. One must invest the effort in:
1. Infrastructure
2. AutomationAutomated
3. Testing
 Continuous Delivery. Follow the principles of CI as in any development project
 Put all artifacts in to source control
 Automate BuildsContinuous Integration
 Automated Test
 Automated Deployment

### With Microservices development, it is implied that the system may become more complex as services are distributed. Recognize complexity of a distributed system. This also means that there will be operational complexities that need to be addressed. One needs a mature DevOps team to manage lots of services that are being deployed and redeployed regularly. I have found the following helpful with that respect:
1. Enable the Diagnostics extensions for the VMs to be provisioned on the Service Fabric Cluster. This can be done via automation using an ARM template, PowerShell, or Xplat-CLI. The portal allows to turn on the Diagnostics extensions as well if creating the Service Fabric Cluster via the portal.
2. You can use Elasticsearch which is an open-source full-text search and analytics engine.  This will help you in storing, searching, and analyzing large volumes of data in real time. You can also send Service Fabric Logs to Elastic Search and host a highly available [Elasticsearch deployment](https://www.elastic.co/guide/index.html) on Azure.
3. In addition, you can use [Kibana](https://www.elastic.co/products/kibana) to display data indexed by Elasticsearch.
4. Of course, you can rely on the Service Fabric Explorer to track health of the cluster and services and get basic diagnostics information.
















