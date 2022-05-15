#!bin/bash
sudo apt update
sudo apt-get -y install git binutils
git clone https://github.com/aws/efs-utils
cd efs-utils/
./build-deb.sh
sudo apt-get -y install ./build/amazon-efs-utils*deb
sudo pip3 install --target /usr/lib/python3/dist-packages botocore
