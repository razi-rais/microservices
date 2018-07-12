#!/bin/bash

################################
## install-k8s-lab-software.sh
###############################

HELM_PACKAGE_NAME="helm-v2.9.1-linux-amd64.tar.gz"
MINIKUBE_VERSION="v0.28.0"
AZURE_CLI_VERSION="2.0.38-1~xenial"

# az cli: (make sure to install particular version)
echo '**** Installing Azure CLI *****' 

        AZ_REPO=$(lsb_release -cs)
        echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $AZ_REPO main" | \
        sudo tee /etc/apt/sources.list.d/azure-cli.list

        curl -L https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
        sudo apt-get install -y apt-transport-https

        #Install latest version of az-cli, find a way to install specific version. https://packages.microsoft.com/repos/azure-cli/dists/xenial/main/binary-amd64/Packages
        sudo apt-get -y update && sudo apt-get install -y azure-cli=$AZURE_CLI_VERSION

        curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# docker:
echo '**** Installing Docker Engine CE *****' 
    sudo apt-get -y update

    sudo apt-get -y install \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common

    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

    sudo add-apt-repository \
     "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
     $(lsb_release -cs) \
     stable"

     sudo apt-get update

     sudo apt-get -y install docker-ce

     # Must exit current session after following command for it to take effect
     sudo gpasswd -a $USER docker

# kubectl:
echo '**** Installing Kubectl *****'

    sudo apt-get -y update && sudo apt-get install -y apt-transport-https
    curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
    sudo touch /etc/apt/sources.list.d/kubernetes.list 
    echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
    sudo apt-get -y update
    sudo apt-get install -y kubectl


# helm:
echo '**** Installing Helm *****' 
     #Download stable release from: https://github.com/kubernetes/helm/releases

     curl -O https://storage.googleapis.com/kubernetes-helm/$HELM_PACKAGE_NAME
     tar -zxvf $HELM_PACKAGE_NAME
     sudo mv linux-amd64/helm /usr/local/bin/helm
     rm $HELM_PACKAGE_NAME

# minikube:
echo '**** Installing Minikube *****'

    sudo apt-get -y update 
    sudo apt-get -y upgrade

    #Make sure no prior copy of minikube exists.
    sudo rm -rf .minikube/

    #Install minikube. Make sure to check for latest version (e.g. current version is 0.28.0)
    curl -Lo minikube https://storage.googleapis.com/minikube/releases/$MINIKUBE_VERSION/minikube-linux-amd64 && chmod +x minikube && sudo mv minikube /usr/local/bin/

    #Install kvm2
    curl -LO https://storage.googleapis.com/minikube/releases/latest/docker-machine-driver-kvm2 && chmod +x docker-machine-driver-kvm2 && sudo mv docker-machine-driver-kvm2 /usr/bin/

    sudo apt install -y libvirt-bin qemu-kvm

    sudo usermod -a -G libvirtd $(whoami)

    #Check to ensure libvirtd service is running.
    #systemctl status libvirtd

    sudo minikube start --vm-driver kvm2
