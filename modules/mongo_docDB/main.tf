resource "aws_docdb_subnet_group" "mongodoc_subnet_group" {
  name = "${var.name_prefix}-mongodoc-sub-group"
  subnet_ids = var.private_subnet_ids

  tags = {
    Name = "${var.name_prefix}-mongodoc-sub-group"
  }
  
}

resource "aws_docdb_cluster" "mongodoc_cluster" {
  cluster_identifier = "${var.name_prefix}-mongodoc-cluster"
  master_username = var.mongo_username
  master_password = var.mongo_password

  db_subnet_group_name = aws_docdb_subnet_group.mongodoc_subnet_group.name
  vpc_security_group_ids = [var.mongodoc_sg_id]

  storage_type = "standard"

  backup_retention_period = 1
  skip_final_snapshot = true
  deletion_protection = false

  tags = {
    Name = "${var.name_prefix}-mongodoc-cluster"
  }
  
}


resource "aws_docdb_cluster_instance" "mongodoc_cluster_instance" {
  identifier = "${var.name_prefix}-mongodoc-instance-1"
  cluster_identifier = aws_docdb_cluster.mongodoc_cluster.id
  instance_class = var.mongo_instance_class
  apply_immediately = true

  tags = {
    Name = "${var.name_prefix}-mongodoc-instance"
  }
  
}