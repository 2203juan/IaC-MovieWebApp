#!/bin/bash
sudo su
sudo apt install apt-transport-https ca-certificates curl software-properties-common -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
apt-cache policy docker-ce
sudo apt install docker-ce -y
apt install python3 python3-pip -y
pip3 install docker docker-compose

docker run -d -p 3030:3030 --name front -e BACK_HOST=${back_host} juan2203/movie-ui:latest