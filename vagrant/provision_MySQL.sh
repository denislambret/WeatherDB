#!/usr/bin/env bash
echo "Now installing MySQL and setting up configuration..."

# Switch to non interactive mode
#export DEBIAN_FRONTEND=noninteractive

# if we need any dependencies, install them here
sudo apt-get update
DBPASSWD="password"
DEBIAN_FRONTEND=noninteractive 
debconf-set-selections <<< "mysql-server mysql-server/root_password password $DBPASSWD"
debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $DBPASSWD"
sudo apt-get install -y -q mysql-server
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mysql/my.cnf
restart mysql

# Give all privileges to root user
sudo /usr/bin/mysqladmin -uroot mysql <<< "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%';FLUSH PRIVILEGES;"