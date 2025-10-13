
output "private_subnet_id" {
  value = [ for az in aws_subnet.private_subnet : az.id]
}

output "vpc_id" {
  value = aws_vpc.test_vpc.id
}

