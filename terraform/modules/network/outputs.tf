output "vpc_id"            { value = aws_vpc.main.id }
output "public_subnet_ids" { value = [for s in aws_subnet.public  : s.id] }
output "private_subnet_ids"{ value = [for s in aws_subnet.private : s.id] }
output "rds_subnet_ids"    { value = [for s in aws_subnet.db_private     : s.id] }
output "db_subnet_group"   { value = aws_db_subnet_group.main.name }
