### Author : Razi Rais
##### Usage: Run following instructions on Ubuntu 16.04 LTS
##### NOTE: If you're using Azure make that vm support nested virtualization (e.g. Standard_D2s_v3):https://docs.microsoft.com/en-us/azure/virtual-machines/windows/sizes-general#dsv3-series-sup1sup
# sudo -i
# sudo curl -O https://raw.githubusercontent.com/razi-rais/microservices/master/reference-material/install-minikube-ubuntu16.04LTS.sh
# sudo chmod +x $PWD/install-minikube-ubuntu16.04LTS.sh
# ./install-minikube-ubuntu16.04LTS.sh 
##########################################


sudo apt-get -y update 
sudo apt-get -y upgrade

#Install kubectl (latest)
curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl

#Make the kubectl binary executable.
chmod +x ./kubectl

#Move the binary in to your PATH.
sudo mv ./kubectl /usr/local/bin/kubectl

#Install minikube. Make sure to check for latest version (current version is 0.24.1)
curl -Lo minikube https://storage.googleapis.com/minikube/releases/v0.24.1/minikube-linux-amd64 && chmod +x minikube && sudo mv minikube /usr/local/bin/

#Install kvm2
curl -LO https://storage.googleapis.com/minikube/releases/latest/docker-machine-driver-kvm2 && chmod +x docker-machine-driver-kvm2 && sudo mv docker-machine-driver-kvm2 /usr/bin/

#Install Install libvirt and qemu-kvm and libvirt-bin
sudo apt install -y qemu-kvm libvirt-bin

#Add group libvirtd
sudo addgroup libvirtd
#Add current user to libvirtd group
sudo adduser $USER libvirtd

#Run minikube
minikube start --vm-driver kvm2
