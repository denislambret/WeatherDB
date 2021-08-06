#!/usr/bin/env bash
echo "------------------------------------------------------------------------------"
echo "Shell provisioning <null> script"
echo "------------------------------------------------------------------------------"
sudo yum clean all
sudo yum check-update
sudo yum update -y
sudo yum upgrade -y



