output "vpc_id"            { value = aws_vpc.network.id }
output "public_subnet_ids" { value = [for s in aws_subnet.public_sn  : s.id] }
output "private_subnet_ids"{ value = [for s in aws_subnet.private_sn : s.id] }
output "rds_subnet_ids"    { value = [for s in aws_subnet.db_private_sn     : s.id] }
output "db_subnet_group"   { value = aws_db_subnet_group.db_subnet_group.name }
