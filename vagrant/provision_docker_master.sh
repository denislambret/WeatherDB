#!/usr/bin/env bash
echo "Now installing Docker and setting up configuration..."
yum update -y
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
yum install -y docker-ce
systemctl start docker
systemctl enable docker
usermod -aG docker vagrant

echo "Now installing Portainer and setting up configuration..."
docker volume create portainer_data
docker run -d --name portainer_master --restart=always -p 9000:9000 -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer

# echo "Create Docker Swarm ..."
# docker swarm init --advertise-addr 192.168.33.10:2377

# echo "Create www service ..."
# docker create volume www
# docker service create --name redis --replicas=4 --mount type=volume,source=www,destination=/usr/share/nginx/html nginx:latest