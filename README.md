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

# Useful commands
- Connect to the ssh `cd ~/.ssh`
-

# EC2
- Launch instance
## OS
- Unbuntu Server 18.04
## Instance type
- t2.micro
## Instance Details
- subnet: ... |Default in eu-west-1a#
- Auto-assign Public IP: enable
## Storage
- do nowt
## Tags
- Add tag {Name: eng99_joseph_app}
## Configure security
### App
- Type: HTTP, Source: Anywhere-IPV4 #Allowing public access
- Type: Custom TCP, Port: 3000, 0.0.0.0 #Allow access for node app on port 3000
- Type: SSH, Source: My IP # only I can ssh into the port from my address
### DB
- Type: SSH, Source: My IP
- Type Custom TCP, Port 27017, [whatever the app ID is] # Only the app can access the database

# Making an Amazon Machine Image (AMI)
- Go to instances (in the EC2 Dashboard)
- Select the desired instances
- Give sensible name e.g. eng99_joseph_app_ami_ec2
- create image

- You can then make a new EC2 environment by launching the instance

# Cloud Watch, Alarms and SNS
- Go to instances (in the EC2 Dashboard)
- Select the desired instances
- Action -->  Monitor and troubleshoot --> Manage CloudWatch alarms
- Set up conditions, ensure to create an alarm notification topic
- Navigate to sns --> topics and select the topic created from alarm
- --> to subscriptions, create a subscription using the topic

# Making an app highly available and scalable
## High Availability
- High Availability (HA) describes systems that are dependable enough to operate continuously without failing. They are well-tested and sometimes equipped with redundant components.
- To achieve high availability, first identify and eliminate single points of failure in the operating system’s infrastructure. Any point that would trigger a mission critical service interruption if it was unavailable qualifies here.
- https://avinetworks.com/glossary/high-availability/
### High Availability in AWS
- create an autoscaling group with min capacity=1 and max capacity=1. So whenever your instance fails, the autoscaling group will create a new one. The autoscaling group comes for free, so this is not a bad solution depending on your SLA.
- use ec2 auto-recovery feature by creating a cloudwatch alarm that would replace your instance if failed.
- create two EC2 instances and use Route 53 DNS failover to resolve to an healthy instance
Last but not least: the best solution is definitely to create several instances across several availability zones and to use an elastic load balancer to distribute the traffic. This way, even if an instance fails, you already have other ones available. AWS recommends this solution as they have an SLA of 99.95% for their instance in an AZ. By putting in several AZs you can have 100% availability
- https://stackoverflow.com/questions/36709830/ec2-amazon-high-availability-always-on
## Scalability
- Ability to increase or decrease IT resources as needed to meet changing demand
### Scalability in AWS
- AWS Auto Scaling, it’s easy to setup application scaling for multiple resources across multiple services in minutes
