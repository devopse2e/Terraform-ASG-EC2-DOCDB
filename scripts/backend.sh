#!/bin/bash

# Install git
sudo yum install -y git

# Install nodejs (Node.js 18 here)
curl -sL https://rpm.nodesource.com/setup_18.x | sudo bash -
sudo yum install -y nodejs
sudo yum install -y nc

# Clone your repo (replace URL with actual)
sudo -u ec2-user git clone https://github.com/devopse2e/OrbitTasks-V1.git /home/ec2-user/OrbitTasks
sudo chown -R ec2-user:ec2-user /home/ec2-user/OrbitTasks
sleep 5

# Decode the JWT secret and create the .env file
# The secret is received as a Base64 encoded string and decoded here.
DECODED_JWT_SECRET=$(echo "${jwt_secret}" | base64 --decode)

# Write backend .env file with multiple vars
echo -e "MONGO_URI=${mongo_uri}\nPORT=${port}\nJWT_SECRET=$${DECODED_JWT_SECRET}" > /home/ec2-user/OrbitTasks/backend/.env
sudo chown ec2-user:ec2-user /home/ec2-user/OrbitTasks/backend/.env

# Download the AWS CA bundle required for TLS connection to DocumentDB
sudo mkdir -p /etc/ssl/certs
sudo curl -fsSL -o /etc/ssl/certs/rds-combined-ca-bundle.pem https://truststore.pki.rds.amazonaws.com/global/global-bundle.pem

# Extract the hostname from the full MONGO_URI
# This command uses sed to pull out just the DNS name of the cluster endpoint
DOCDB_HOST=$(echo "${mongo_uri}" | sed -E 's#^mongodb://[^@]+@([^:]+):[0-9]+.*$#\1#')

echo "Checking connectivity to DocumentDB at $${DOCDB_HOST}:27017..."

# Loop until a successful TCP connection can be made to the DocumentDB host on port 27017
# -z: Zero-I/O mode (scanning)
# -v: Verbose
# -w3: Timeout after 3 seconds
until nc -z -v -w3 "$${DOCDB_HOST}" 27017; do
  echo "Waiting for DocumentDB to be available..."
  sleep 5
done

echo "✅ DocumentDB is reachable. Starting backend application..."

# --- End of Readiness Check ---

# Start backend
cd /home/ec2-user/OrbitTasks/backend
sudo -u ec2-user npm install
sleep 10 
sudo -u ec2-user npm start &

