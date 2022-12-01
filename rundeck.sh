#!/bin/bash
sudo apt update
sudo apt install openjdk-8-jre -y
curl https://raw.githubusercontent.com/rundeck/packaging/main/scripts/deb-setup.sh 2> /dev/null | sudo bash -s rundeck
sudo apt-get update
sudo apt-get install rundeck -y
sudo service rundeckd start
