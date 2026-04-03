#!/bin/bash

# We are creating 50GB root disk, but only 20GB is partitioned
# Remaining 30GB we need to extend using below commands

growpart /dev/nvme0n1 4
lvextend -r -L +30G /dev/mapper/RootVG-homeVol
xfs_growfs /home


sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
sudo yum -y install terraform

# cd /home/ec2-user
#git clone https://github.com/Varun-Kumar-Pinnam/roboshop-infra-dev.git


# creating databases
cd /home/ec2-user
sudo -u ec2-user git clone https://github.com/Varun-Kumar-Pinnam/roboshop-infra-dev.git
cd roboshop-infra-dev/40-databases
terraform init
terraform apply -auto-approve

# creating components   
cd /home/ec2-user
#git clone https://github.com/daws-88s/roboshop-infra-dev.git
#sudo -u ec2-user git clone https://github.com/Varun-Kumar-Pinnam/roboshop-infra-dev.git
cd roboshop-infra-dev/90-components
terraform init
terraform apply -auto-approve