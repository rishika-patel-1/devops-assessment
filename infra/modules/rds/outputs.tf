output "db_subnet_group_name" {
  description = "RDS DB Subnet Group Name"
  value       = aws_db_subnet_group.main.name
}

output "db_instance_endpoint" {
  description = "RDS Endpoint"
  value       = aws_db_instance.main.endpoint
}

output "db_instance_address" {
  description = "RDS Address"
  value       = aws_db_instance.main.address
}

output "db_instance_id" {
  description = "RDS Instance ID"
  value       = aws_db_instance.main.id
}