 ##############################################################
 #Allows you to open IE explorer automatically and browse to Container IP Address and Port (default is 80)
 #Required: You need to pass valid container name. docker run --name swtich gives you ability to do that.  
 ##############################################################
 
 function BrowseContainer{
 
 Param($containerName,$port = 80)
 

 Write-Host "Container Name: $containerName"
 $containerId = docker ps --filter name=$containerName -q;
 Write-Host "Container ID: $containerId"
 $containerIP = docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $containerId;
 Write-Host "Container IP Address: $containerIP"

 Start-Process -FilePath "c:\Program Files\Internet Explorer\iexplore.exe"  -ArgumentList "http://$containerIP`:$port"
}

BrowseContainer $args[0]
