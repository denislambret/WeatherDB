#!/usr/bin/env bash
echo "------------------------------------------------------------------------------"
echo "Shell provisioning <null> script"
echo "------------------------------------------------------------------------------"
sudo yum clean all
sudo yum check-update
sudo yum update -y
sudo yum upgrade -y

set passwd = "1234qweASD"
sudo useradd -m dummy -p $passwd -G wheel
sudo userdel dev

echo "------------------------------------------------------------------------------"
echo " Python 3.7 + libraries"
echo "------------------------------------------------------------------------------"

sudo apt-get install python3.7
sudo apt-get install python-pandas

