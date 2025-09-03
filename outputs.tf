output "vpc_id" {
    description = "vpc id "
    value = module.vpc.vpc_id
  
}

output "public_subnet_ids" {
    description = "public subnet id's"
    value = module.vpc.public_subnet_ids
  
}

output "private_subnet_ids" {
    description = "private subnet id's"
    value = module.vpc.private_subnet_ids
  
}
output "igw_id" {
    description = "igw id of this project"
    value = module.igw.igw_id
  
}
output "public_route_table_id" {
    description = "public route table id"
    value = module.route_tables.public_route_table_id
}

output "private_route_table_id" {
    description = "private route table id"
    value = module.route_tables.private_route_table_ids 
}


output "nat_gw_id" {
    description = "nat gw id"
    value = module.nat_gw.nat_gw_id
  
}


output "jumpbox_sg_id" {
    description = "jumpbox security groups id"
    value = module.security_groups.jumpbox_sg_id
}

output "internet_alb_sg_id" {
    description = "internet alb security groups id"
    value = module.security_groups.internet_alb_sg_id
}

output "frontend_sg_id" {
    description = "frontend security groups id"
    value = module.security_groups.frontend_sg_id
  
}

output "internal_alb_sg_id" {
    description = "internal alb security groups id"
    value = module.security_groups.internal_alb_sg_id
  
}

output "backend_sg_id" {
    description = "backend security groups id"
    value = module.security_groups.backend_sg_id
  
}

output "mongodoc_sg_id" {
    description = "mongodb security groups id"
    value = module.security_groups.mongodoc_sg_id
  
}

output "jumpbox_instance" {
    description = "jumpbox instance id "
    value = module.jumpbox_instance.jumpbox_instance_id
    
}
output "mongodoc_writer_endpoint" {
    description = "writer endpoint of mongodocdb"
    value = module.mongodocdb.mongodoc_writer_endpoint
  
}
output "mongododc_reader_endpoint" {
    description = "reader endpoint of mongodocdb"
    value = module.mongodocdb.mongododc_reader_endpoint
  
}