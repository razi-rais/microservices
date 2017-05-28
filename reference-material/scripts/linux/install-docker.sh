#prepare & install docker engine (https://docs.docker.com/compose/install)
sudo apt-get install -y --no-install-recommends \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common

curl -fsSL https://apt.dockerproject.org/gpg | sudo apt-key add -

apt-key fingerprint 58118E89F3A912897C070ADBF76221572C52609D

sudo add-apt-repository \
       "deb https://apt.dockerproject.org/repo/ \
       ubuntu-$(lsb_release -cs) \
       main"

sudo apt-get update

sudo apt-get -y install docker-engine

#update permissions to allow current user run docker commands without sudo
sudo gpasswd -a $USER docker

sudo service docker restart

sudo systemctl docker restart


#install docker-compose
#version needs to be updated with every major release of docker-compose 

sudo -i 

curl -L https://github.com/docker/compose/releases/download/1.13.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose

sudo chmod +x /usr/local/bin/docker-compose

exit
