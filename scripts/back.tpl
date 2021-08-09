#!/bin/bash
sudo su
sudo apt install apt-transport-https ca-certificates curl software-properties-common -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
apt-cache policy docker-ce
sudo apt install docker-ce -y

docker run -p 3000:3000 -e MYSQL_HOST=${host_endpoint} \
                    -e MYSQL_USER=${user_name} \
                    -e MYSQL_PASS=${password} \
                    juan2203/movie-api:latest

