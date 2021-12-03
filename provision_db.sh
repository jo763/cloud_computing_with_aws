#!/bin/bash
# sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 9DA31620334BD75D9DCB49F368818C72E52529D4 -y
# sudo add-apt-repository 'deb [arch=amd64] https://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/4.0 multiverse'
# sudo apt update -y
# sudo apt install mongodb
# sudo apt-get update

# wget -qO - https://www.mongodb.org/static/pgp/server-5.0.asc | sudo apt-key add -
# echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/5.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-5.0.list
# sudo apt-get update
#
# sudo ufw allow 27017
# sudo ufw enable

# sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2930ADAE8CAF5059EE73BB4B58712A2291FA4AD5 -y
# echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.6 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.6.list
# sudo apt-get update -y
# sudo apt-get install -y mongodb-org


# be careful of these keys, they will go out of date
sudo apt-get update -y
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv D68FA50FEA312927
echo "deb https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.2.list
sudo apt-get update -y
sudo apt-get sudo apt-get update -y -y
# sudo apt-get install mongodb-org=3.2.20 -y
sudo apt-get install -y mongodb-org=3.2.20 mongodb-org-server=3.2.20 mongodb-org-shell=3.2.20 mongodb-org-mongos=3.2.20 mongodb-org-tools=3.2.20
# if mongo is is set up correctly these will be successful
sudo systemctl restart mongod
sudo systemctl enable mongod

#sudo rm /etc/mongod.conf
#sudo ln -s /home/vagrant/app/environment/mongod.conf /etc/
# sudo cp /home/vagrant/app/environment/mongod.conf /etc/
sudo systemctl restart mongod
sudo systemctl enable mongod
