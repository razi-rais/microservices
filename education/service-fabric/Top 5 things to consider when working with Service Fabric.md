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
3. Choose the technology stack to implement your Microservices

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
















