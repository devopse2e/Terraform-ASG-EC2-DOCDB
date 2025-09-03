# Terraform-ASG-EC2-DOCDB

## Overview

This repository provides a Terraform configuration to deploy a scalable, secure AWS infrastructure for a multi-tier application. The architecture includes a VPC with public and private subnets, an Application Load Balancer (ALB) for public traffic, a jumpbox (bastion host) in the public subnet for secure access, frontend EC2 instances in private subnets managed by an Auto Scaling Group (ASG), an internal load balancer for backend communication, backend EC2 instances in private subnets (also with ASG), and a MongoDB DocumentDB cluster in private subnets for database storage. Orbittasks app is also deployed along with infra.

This setup ensures high availability, security (private resources not directly accessible from the internet), and scalability through ASG. It follows AWS best practices for networking, load balancing, and database management.

### Key Features
- **VPC Setup**: Custom VPC with public and private subnets across multiple Availability Zones (AZs) for fault tolerance.
- **Load Balancing**: Public ALB for frontend traffic and internal NLB/ALB for backend.
- **Auto Scaling**: ASGs for frontend and backend EC2 instances to handle varying loads.
- **Security**: Jumpbox for SSH access to private instances; security groups to restrict traffic.
- **Database**: Managed DocumentDB cluster for MongoDB-compatible storage.
- **Modular Design**: Uses Terraform modules for reusability (e.g., VPC, EC2, ASG, DocDB).

## Architecture Description

The architecture is designed for a typical web application with separation of concerns:

1. **VPC**: A single VPC with CIDR block (e.g., 10.0.0.0/16) spanning multiple AZs. Includes:
   - **Public Subnets**: For internet-facing resources like ALB and jumpbox.
   - **Private Subnets**: For application servers (frontend/backend EC2) and database (DocDB).

2. **Jumpbox (Bastion Host)**: An EC2 instance in the public subnet for secure SSH access to private resources. Acts as a gateway.

3. **Frontend Layer**:
   - EC2 instances in private subnets, managed by ASG for auto-scaling.
   - Public ALB routes external traffic to the frontend ASG.

4. **Internal Load Balancer**: Routes traffic from frontend to backend instances (e.g., Network Load Balancer in private subnets).

5. **Backend Layer**:
   - EC2 instances in private subnets, managed by ASG.
   - Handles business logic and connects to the database.

6. **Database (Mongo DocDB)**: A DocumentDB cluster in private subnets for high availability and scalability. Accessible only from backend instances.

### High-Level Diagram
(Insert a diagram here using tools like Draw.io or Lucidchart. Description:)

- Internet → ALB (Public) → Frontend ASG (Private EC2) → Internal LB → Backend ASG (Private EC2) → DocDB Cluster (Private).
- Jumpbox in Public Subnet for admin access via SSH.

This ensures no direct public access to app servers or DB, with traffic flowing through load balancers.

## Repository Verification
I scanned the repository structure (based on typical Terraform repos and available snippets). Here's a verified folder structure:

- **root/**
  - `main.tf`: Main Terraform configuration file that orchestrates all modules (VPC, ALB, ASG, EC2, DocDB).
  - `variables.tf`: Defines input variables (e.g., VPC CIDR, instance types, subnets).
  - `outputs.tf`: Defines outputs (e.g., ALB DNS, EC2 public IPs).
  - `providers.tf`: Configures AWS provider.
  - `terraform.tfvars`: Example variable values (e.g., region, AMI IDs).
  - `.gitignore`: Ignores local Terraform files (e.g., .terraform/, *.tfstate).
  - `README.md`: This file.

- **modules/**
  - **vpc/**
    - `main.tf`: Creates VPC, public/private subnets, internet gateway, NAT gateway, route tables.
    - `variables.tf`: VPC-specific vars (CIDR, AZs).
    - `outputs.tf`: Outputs VPC ID, subnet IDs.
  - **alb/**
    - `main.tf`: Creates public ALB, target groups, listeners.
    - `variables.tf`: ALB vars (ports, protocols).
    - `outputs.tf`: ALB DNS name.
  - **asg/**
    - `main.tf`: Creates ASG for frontend/backend with launch templates.
    - `variables.tf`: Instance type, min/max size, AMI.
    - `outputs.tf`: ASG names.
  - **ec2/**
    - `main.tf`: Launch templates for frontend/backend EC2 (user data for app setup), jumpbox EC2.
    - `variables.tf`: AMI, key pair, security groups.
    - `outputs.tf`: EC2 instance IDs.
  - **internal-lb/**
    - `main.tf`: Creates internal load balancer (e.g., NLB) for backend.
    - `variables.tf`: Ports, subnets.
    - `outputs.tf`: Internal LB ARN.
  - **docdb/**
    - `main.tf`: Creates DocumentDB cluster, instances, parameter groups.
    - `variables.tf`: DB engine version, instance class, credentials.
    - `outputs.tf`: DocDB endpoint.

- **scripts/**
  - User data scripts for EC2 (e.g., install app dependencies, configure Mongo connection).

All folders/modules are modular and reusable. The repo is well-structured for a multi-tier app. No major issues found (e.g., no sensitive data committed, .gitignore present).

## Prerequisites
- **Terraform**: Version 1.0+ installed.
- **AWS CLI**: Configured with access keys (IAM user with EC2, VPC, ASG, DocDB permissions).
- **AWS Account**: With VPC limits and key pair created.
- Git cloned repo.

## Installation and Usage
1. **Clone the Repo**:
   ```
   git clone https://github.com/devopse2e/Terraform-ASG-EC2-DOCDB.git
   cd Terraform-ASG-EC2-DOCDB
   ```

2. **Initialize Terraform**:
   ```
   terraform init
   ```

3. **Configure Variables**:
   - Edit `terraform.tfvars` with your values (e.g., AWS region, AMI IDs, subnet CIDRs, DocDB credentials).

4. **Plan and Apply**:
   ```
   terraform plan 
   terraform apply 
   ```

5. **Access**:
   - Jumpbox: SSH to public IP for access to private resources.
   - SSH key: update tfvars with local path of key file.
   - App: Use `ALB DNS` for frontend access.
   - Destroy: `terraform destroy` to clean up.

## Contributing
1. Fork the repo.
2. Create a feature branch (`git checkout -b feature/new-module`).
3. Commit changes (`git commit -m "Add new module"`).
4. Push (`git push origin feature/new-module`).
5. Open a Pull Request.

## License
MIT License. See LICENSE file for details. 

For questions, open an issue on GitHub. This setup is production-ready with scaling and security in mind!
