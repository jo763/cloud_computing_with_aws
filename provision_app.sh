#!/bin/bash
# add environment variable
#echo 'export DB_HOST="mongodb://192.168.10.150:27017/posts"' >> .bashrc -y
sudo rm /etc/nginx/sites-available/default
sudo ln -s /home/vagrant/app/environment/default /etc/nginx/sites-available/
sudo cp /home/vagrant/app/environment/default /etc/nginx/sites-available/
sudo systemctl restart nginx
sudo systemctl enable nginx
echo 'export DB_HOST="mongodb://192.168.10.150:27017/posts"' >> .bashrc -y
# /home/vagrant/app/environment
sleep 30
node /home/vagrant/app/app/seeds/seed.js

# node /home/vagrant/app/app/seeds/seed.js
# npm run
#
