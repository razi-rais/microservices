
#https://github.com/dotnet/dotnet-docker/blob/master/1.1/runtime/jessie/Dockerfile
sudo curl -SL "https://dotnetcli.blob.core.windows.net/dotnet/release/1.1.0/Binaries/1.1.2/dotnet-ubuntu-x64.1.1.2.tar.gz" --output dotnet.tar.gz \
    && sudo mkdir -p /usr/share/dotnet \
    && sudo tar -zxf dotnet.tar.gz -C /usr/share/dotnet \
    && sudo rm dotnet.tar.gz \
    && sudo ln -s /usr/share/dotnet/dotnet /usr/bin/dotnet

