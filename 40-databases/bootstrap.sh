#!/bin/bash

component=$1
environment=$2
dnf install ansible -y 

cd /home/ec2-user

if [ -d "/home/ec2-user/roboshop-ansible-roles-tf" ]; then

    cd /home/ec2-user/roboshop-ansible-roles-tf && git pull
else
    git clone https://github.com/Varun-Kumar-Pinnam/roboshop-ansible-roles-tf.git
fi

cd  /home/ec2-user/roboshop-ansible-roles-tf

ansible-playbook -e component=$component -e env=$environment roboshop.yaml



