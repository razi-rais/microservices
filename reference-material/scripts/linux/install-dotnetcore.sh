#(Ubuntu 16.04) https://www.microsoft.com/net/core#linuxubuntu
sudo sh -c 'echo "deb [arch=amd64] https://apt-mo.trafficmanager.net/repos/dotnet-release/ xenial main" > /etc/apt/sources.list.d/dotnetdev.list'

sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 417A0893

sudo apt-get -y update

sudo apt-get -y install dotnet-dev-1.0.4
