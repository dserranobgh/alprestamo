output "vpc_id" {
  value = aws_vpc.alprestamo-vpc.id
}

output "dev-pub-main-subnet-id" {
  value = aws_subnet.dev-pub-main-subnet.id
}

output "dev-pub-alt-subnet-id" {
  value = aws_subnet.dev-pub-alt-subnet.id
}

output "dev-priv-main-subnet-id" {
  value = aws_subnet.dev-priv-main-subnet.id
}

output "dev-priv-alt-subnet-id" {
    value = aws_subnet.dev-priv-alt-subnet.id  
}

output "security_groups" {
  value = aws_security_group.alprestamo-sg.id
  
}