# Installing Mongo
- sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2930ADAE8CAF5059EE73BB4B58712A2291FA4AD5
- echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.6 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.6.list
- sudo apt-get update
- sudo apt-get install -y mongodb-org
- https://askubuntu.com/questions/767934/mongodb-installation-failed-on-ubuntu-16-04 Rahul K Jha's answer
# Start/stop/reload mongo
- sudo service mongod start
- sudo service mongod stop
- sudo service mongod restart
# Add environment variable permanently
echo "export DB_HOST=192.168.10.150:27017" >> .bashrc -y
# Create multi-VMs
```
- Vagrant.configure("2") do |config|

  config.vm.box = "ubuntu/xenial64"
  #config.vm.network "private_network", ip: "192.168.10.100"
  config.vm.provision "shell", path: "./provision.sh"
  config.vm.synced_folder ".", "/home/vagrant/app"

  config.vm.define "app" do |app|
  app.vm.box = "ubuntu/xenial64"
  app.vm.network "private_network", ip: "192.168.10.100"
  app.vm.provision "shell", path: "./provision_app.sh"
  end

  config.vm.define "db" do |db|
  db.vm.box = "ubuntu/xenial64"
  db.vm.network "private_network", ip: "192.168.10.150"
  db.vm.provision "shell", path: "./provision_db.sh"
  end

  config.vm.synced_folder ".", "/home/vagrant/app"
  #provisisioning

end
```
- https://www.vagrantup.com/docs/multi-machine

# Setting up Nginx as a Reverse Proxy Server
```
- sudo nano /etc/nginx/sites-available/default
- Within the server block you should have an existing location / block. Replace the contents of that block with the following configuration. If your application is set to listen on a different port, update the highlighted portion to the correct port number.
 -     location / {
        proxy_pass http://localhost:8080;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
    }
```
- https://www.digitalocean.com/community/tutorials/how-to-set-up-a-node-js-application-for-production-on-ubuntu-16-04

# Setting up mongoDB
```
#be careful of these keys, they will go out of date
sudo apt-get update -y
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv D68FA50FEA312927
echo "deb https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.2.list
sudo apt-get update -y
sudo apt-get sudo apt-get update -y -y
#sudo apt-get install mongodb-org=3.2.20 -y
sudo apt-get install -y mongodb-org=3.2.20 mongodb-org-server=3.2.20 mongodb-org-shell=3.2.20 mongodb-org-mongos=3.2.20 mongodb-org-tools=3.2.20
#if mongo is is set up correctly these will be successful
sudo systemctl restart mongod
sudo systemctl enable mongod
```
- cd /etc
```
sudo nano mongod.conf
change bindIP to 0.0.0.0 (accessable to all (not secure)) or to desired IP e.g. appIP so only it can access it
```

# Cloud Computing

## What is cloud computing?
- General term for anything that involves delivering hosted services over the internet. These services are divided into three main categories: infrastructure as a service (IaaS), platform as a service (PaaS) and software as a service (SaaS).
- https://searchcloudcomputing.techtarget.com/definition/cloud-computing

## Benefits of cloud computing?
- Cost Savings
- Security
- Flexibility
- Mobility
- Insight
- Increased Collaboration
- Quality Control
- Disaster Recovery
- Loss Prevention
- Automatic Software Updates
- Competitive Edge
- Sustainability
- https://www.salesforce.com/products/platform/best-practices/benefits-of-cloud-computing/

## Who is using cloud computing in their IT tech?
- Netflix (using AWS)
- Pinterest (using AWS)
- Coca-cola  (using AWS)
- Etsy (using Google Cloud)
- eBay (using Google Cloud)
- Twitter (ad platform) (using Google Cloud)
- Paypal (using Google Cloud)
- https://customerthink.com/top-10-companies-using-cloud-and-why/

## What is IaaS, PaaS, SaaS?
- IaaS: pay-as-you-go access to storage, networking, servers, and other computing resources in the cloud.
- Paas: cloud-based environment in which users can build and deliver applications. The provider supplies underlying infrastructure.
- SaaS: delivers software and applications through the internet. Users subscribe to the software and access it via the web or vendor APIs.
- https://www.ibm.com/uk-en/cloud/learn/iaas-paas-saas

## What is AWS?
- Leading cloud platform
- AWS (Amazon Web Services) is a comprehensive, evolving cloud computing platform provided by Amazon that includes a mixture of infrastructure as a service (IaaS), platform as a service (PaaS) and packaged software as a service (SaaS) offerings.

## Key benefits of AWS?
- Easy to use
- Flexible
- Cost-Effective
- Reliable
- Scalable and high-performance
- Secure
- https://aws.amazon.com/application-hosting/benefits/
