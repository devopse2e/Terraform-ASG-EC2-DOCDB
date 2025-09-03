#!/bin/bash
set -e

# Update packages
sudo yum update -y

# Add the MongoDB repository
sudo tee /etc/yum.repos.d/mongodb-org-7.0.repo <<EOF
[mongodb-org-7.0]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/amazon/2/mongodb-org/7.0/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-7.0.asc
EOF

# Install ONLY the MongoDB Shell, not the entire database
sudo yum install -y mongodb-org-shell

# Download the AWS CA bundle for TLS connection
sudo mkdir -p /etc/ssl/certs
sudo curl -fsSL -o /etc/ssl/certs/rds-combined-ca-bundle.pem https://truststore.pki.rds.amazonaws.com/global/global-bundle.pem

echo "MongoDB Shell and AWS CA certificate installed."
echo "You can now connect to DocumentDB using mongosh with TLS."
