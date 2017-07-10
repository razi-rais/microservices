#install azure cli 2.0
#https://docs.microsoft.com/en-us/cli/azure/install-azure-cli#apt-get-for-debianubuntu

echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ wheezy main" | sudo tee /etc/apt/sources.list.d/azure-cli.list

sudo apt-key adv --keyserver packages.microsoft.com --recv-keys 417A0893
sudo apt-get -y install apt-transport-https
sudo apt-get -y update && sudo apt-get install azure-cli
