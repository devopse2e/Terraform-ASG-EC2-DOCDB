#!/bin/bash

# Install MongoDB on Amazon Linux 2
sudo tee /etc/yum.repos.d/mongodb-org-7.0.repo <<EOF
[mongodb-org-AL2023]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/amazon/2023/mongodb-org/7.0/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-7.0.asc
EOF

sudo yum install -y mongodb-org

# This replaces the default 127.0.0.1 binding
if grep -q "bindIp: 127.0.0.1" /etc/mongod.conf; then
  sudo sed -i 's/bindIp: 127\.0\.0\.1/bindIp: 0.0.0.0/' /etc/mongod.conf
fi

# Start MongoDB service and enable it on boot
sudo systemctl restart mongod
sudo systemctl enable mongod
