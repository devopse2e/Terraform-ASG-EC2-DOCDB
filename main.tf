module "vpc" {
    source = "./modules/vpc"
    vpc_cidr = var.vpc_cidr
    azs = var.azs
    public_subnet_cidr = var.public_subnet_cidr
    private_subnet_cidr = var.private_subnet_cidr
    name_prefix = var.name_prefix
  
}

module "igw" {
    source = "./modules/igw"
    vpc_id = module.vpc.vpc_id
    name_prefix = var.name_prefix
}

module "route_tables" {
    source = "./modules/route_tables"
    azs = var.azs
    vpc_id = module.vpc.vpc_id
    name_prefix = var.name_prefix
    igw_id = module.igw.igw_id
    public_subnet_id = module.vpc.public_subnet_ids
    private_subnet_id = module.vpc.private_subnet_ids
    nat_gw_id = module.nat_gw.nat_gw_id
}

module "nat_gw" {
    source = "./modules/nat"
    public_subnet_id = module.vpc.public_subnet_ids[0]
    name_prefix = var.name_prefix
    create_nat      = var.create_nat 
}

module "security_groups" {
    source = "./modules/security_groups"
    vpc_id = module.vpc.vpc_id
    name_prefix = var.name_prefix
    allowed_ssh_cidr = var.allowed_ssh_cidr
}

module "internet_alb" {
    source = "./modules/internet_ALB"
    name_prefix = var.name_prefix
    vpc_id = module.vpc.vpc_id
    internet_alb_sg_id = module.security_groups.internet_alb_sg_id
    public_subnet_ids = module.vpc.public_subnet_ids
}

module "internal_alb" {
    source = "./modules/internal_ALB"
    name_prefix = var.name_prefix
    vpc_id = module.vpc.vpc_id
    internal_alb_sg_id = module.security_groups.internal_alb_sg_id
    private_subnet_ids = module.vpc.private_subnet_ids
}

module "jumpbox_instance" {
    source = "./modules/jump_box"
    ami_id = var.ami_id
    instance_type = var.instance_type
    subnet_id = module.vpc.public_subnet_ids[0]
    key_name = var.key_name
    jump_box_sg_id = module.security_groups.jumpbox_sg_id
    name_prefix = var.name_prefix
    ssh_private_key_path = var.ssh_private_key_path
  
}
module "frontend_ASG" {
    source = "./modules/frontend_ASG"
    ami_id = var.ami_id
    instance_type = var.instance_type
    private_subnet_ids = module.vpc.private_subnet_ids
    key_name = var.key_name
    frontend_sg_id = module.security_groups.frontend_sg_id
    name_prefix = var.name_prefix
    target_group_arn = module.internet_alb.internet_alb_frontend_tg_arn
    react_app_api_url = "/api"
    backend_url = "http://${module.internal_alb.internal_alb_dns_name}"
}

module "backend_ASG" {
    source = "./modules/backend_ASG"
    ami_id = var.ami_id
    instance_type = var.instance_type
    key_name = var.key_name
    backend_sg_id = module.security_groups.backend_sg_id
    name_prefix = var.name_prefix
    target_group_arn = module.internal_alb.internal_alb_backend_tg_arn
    private_subnet_ids = module.vpc.private_subnet_ids
    mongo_uri = "mongodb://${var.mongo_username}:${var.mongo_password}@${module.mongodocdb.mongodoc_writer_endpoint}:27017/orbittasks?ssl=true&replicaSet=rs0&readPreference=primary&retryWrites=false&authMechanism=SCRAM-SHA-1"  
}
module "mongodocdb" {
    source = "./modules/mongo_docDB"
    mongo_instance_class = var.mongodoc_instance_class
    private_subnet_ids = module.vpc.private_subnet_ids
    mongodoc_sg_id = module.security_groups.mongodoc_sg_id
    name_prefix = var.name_prefix
    mongo_username = var.mongo_username
    mongo_password = var.mongo_password
}