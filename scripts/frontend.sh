#!/bin/bash

# Install git
sudo yum install -y git

# Install Node.js 18
curl -sL https://rpm.nodesource.com/setup_18.x | sudo bash -
sudo yum install -y nodejs

# Clone repo
sudo -u ec2-user git clone https://github.com/devopse2e/OrbitTasks-V1.git /home/ec2-user/OrbitTasks
sudo chown -R ec2-user:ec2-user /home/ec2-user/OrbitTasks
sleep 5

# Write frontend .env file (React app + backend proxy)
cat <<EOF > /home/ec2-user/OrbitTasks/frontend/.env
REACT_APP_API_URL=${react_app_api_url}
BACKEND_URL=${backend_url}
EOF
sudo chown ec2-user:ec2-user /home/ec2-user/OrbitTasks/frontend/.env

# Build frontend for production
cd /home/ec2-user/OrbitTasks/frontend
sudo -u ec2-user npm install
sleep 5
sudo -u ec2-user npm run build

# Start the Express server (from package.json "start" script)
# This will serve the React dist/ folder and proxy /api to BACKEND_URL
sudo -u ec2-user npm start &
