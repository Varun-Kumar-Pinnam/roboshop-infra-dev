#!/bin/bash

component = $1
environment = $2
dnf install ansible -y 

cd /home/ec2-user

git clone https://github.com/Varun-Kumar-Pinnam/roboshop-ansible-roles-tf.git

cd roboshop-ansible-roles-tf

ansible-playbook -e component=$component -e env=$environment roboshop.yaml


