sudo mkdir install-scripts
cd install-scripts

#un-comment commands related to docker if you're not using azure ubuntu 16.04 vm image that comes with docker installed on it.

#sudo curl -O https://raw.githubusercontent.com/razi-rais/microservices/master/reference-material/scripts/linux/install-docker.sh
sudo curl -O https://raw.githubusercontent.com/razi-rais/microservices/master/reference-material/scripts/linux/install-nodejs.sh
sudo curl -O https://raw.githubusercontent.com/razi-rais/microservices/master/reference-material/scripts/linux/install-yeoman.sh
sudo curl -O https://raw.githubusercontent.com/razi-rais/microservices/master/reference-material/scripts/linux/install-dotnetcore.sh
sudo curl -O https://raw.githubusercontent.com/razi-rais/microservices/master/reference-material/scripts/linux/install-git.sh
sudo curl -O https://raw.githubusercontent.com/razi-rais/microservices/master/reference-material/scripts/linux/install-azure-cli.sh
sudo curl -O https://raw.githubusercontent.com/razi-rais/microservices/master/reference-material/scripts/linux/install-bower.sh

#sudo chmod +x $PWD/install-docker.sh
sudo chmod +x $PWD/install-nodejs.sh
sudo chmod +x $PWD/install-yeoman.sh
sudo chmod +x $PWD/install-dotnetcore.sh
sudo chmod +x $PWD/install-git.sh
sudo chmod +x $PWD/install-azure-cli.sh
sudo chmod +x $PWD/install-bower.sh

#./install-docker.sh 
./install-nodejs.sh
./install-yeoman.sh 
./install-dotnetcore.sh
./install-git.sh
./install-azure-cli.sh
./install-bower.sh







