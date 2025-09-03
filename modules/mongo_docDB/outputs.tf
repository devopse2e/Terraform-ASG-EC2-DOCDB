output "mongodoc_writer_endpoint" {
    description = "writer endpoint of mongodocdb"
    value = aws_docdb_cluster.mongodoc_cluster.endpoint
  
}
output "mongododc_reader_endpoint" {
    description = "reader endpoint of mongodocdb"
    value = aws_docdb_cluster.mongodoc_cluster.reader_endpoint
  
}
