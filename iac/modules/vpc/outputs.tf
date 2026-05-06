output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.main.id
}

output "vpc_cidr" {
  description = "VPC CIDR block"
  value       = aws_vpc.main.cidr_block
}

output "public_subnet_ids" {
  description = "Public subnet IDs"
  value       = aws_subnet.public[*].id
}

output "web_private_subnet_ids" {
  description = "Web private subnet IDs"
  value       = aws_subnet.web_private[*].id
}

output "app_private_subnet_ids" {
  description = "App private subnet IDs"
  value       = aws_subnet.app_private[*].id
}

output "db_private_subnet_ids" {
  description = "DB private subnet IDs"
  value       = aws_subnet.db_private[*].id
}

output "internet_gateway_id" {
  description = "Internet Gateway ID"
  value       = aws_internet_gateway.main.id
}

output "nat_gateway_ips" {
  description = "Elastic IPs of NAT Gateways"
  value       = aws_eip.nat[*].public_ip
}

output "public_route_table_id" {
  description = "Public Route Table ID"
  value       = aws_route_table.public.id
}

output "private_route_table_id" {
  description = "Private route table ID"
  value       = aws_route_table.private.id
}
