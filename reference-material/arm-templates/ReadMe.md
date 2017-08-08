# Azure - Linux Docker Developer Virtual Machine

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

# Azure - Windows Container Developer Virtual Machine

Azure ARM template that creates Azure Windows Server 2016 VM with following software installed:

* Windows Server 2016
* Windows Containers (NOTE: For Docker for Windows use the other ARM template)
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

