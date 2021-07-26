#!/bin/bash
# install nodejs
sudo su

cd ~
curl -sL https://deb.nodesource.com/setup_14.x -o nodesource_setup.sh

bash nodesource_setup.sh

apt install nodejs -y

apt install build-essential -y

# clone my repository

git clone https://github.com/2203juan/movie-analyst-api.git

# install project dependencies
cd movie-analyst-api

npm i nodemon

npm i express

npm i mysql

# init application

npm install -g pm2

export MYSQL_HOST=${host_endpoint}
export MYSQL_USER=${user_name}
export MYSQL_PASS=${password}

pm2 start server.js --name "backend-api"