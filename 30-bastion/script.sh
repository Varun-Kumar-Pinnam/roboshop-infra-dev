#!/bin/bash

# Exit immediately if a command fails
set -e
set -o pipefail

echo "===== STARTING SETUP ====="

# Disk extension
echo "Extending disk..."
growpart /dev/nvme0n1 4
lvextend -r -L +30G /dev/mapper/RootVG-homeVol
xfs_growfs /home

# Install Terraform
echo "Installing Terraform..."
yum install -y yum-utils
yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
yum install -y terraform


# Move to ec2-user home
cd /home/ec2-user

# Clone repo only if not exists (idempotent)
if [ ! -d "roboshop-infra-dev" ]; then
  echo "Cloning repository..."
  sudo -u ec2-user git clone https://github.com/Varun-Kumar-Pinnam/roboshop-infra-dev.git
else
  echo "Repo already exists, skipping clone..."
fi

# Ensure ownership (safe fallback)
chown -R ec2-user:ec2-user /home/ec2-user/roboshop-infra-dev


# ==============================
# Create Databases
# ==============================
echo "Creating databases..."
cd /home/ec2-user/roboshop-infra-dev/40-databases

sudo -u ec2-user terraform init
sudo -u ec2-user terraform apply -auto-approve

# ==============================
# Create Components
# ==============================
echo "Creating components..."
cd /home/ec2-user/roboshop-infra-dev/90-components

sudo -u ec2-user terraform init
sudo -u ec2-user terraform apply -auto-approve

echo "===== SETUP COMPLETED SUCCESSFULLY ====="