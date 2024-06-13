resource "aws_vpc" "vpc" {
 cidr_block = "10.0.0.0/16"
}
resource "aws_subnet" "subnet1" {
 vpc_id            = aws_vpc.vpc.id
 cidr_block        = "10.0.1.0/24"
 availability_zone = "us-east-1a"
 map_public_ip_on_launch = true
}
resource "aws_subnet" "subnet2" {
 vpc_id            = aws_vpc.vpc.id
 cidr_block        = "10.0.2.0/24"
 availability_zone = "us-east-1b"
 map_public_ip_on_launch = true
}
resource "aws_internet_gateway" "ig" {
 vpc_id = aws_vpc.vpc.id
}
resource "aws_route_table" "rt" {
 vpc_id = aws_vpc.vpc.id
 route {
   cidr_block = "0.0.0.0/0"
   gateway_id = aws_internet_gateway.ig.id
 }
}
resource "aws_route_table_association" "rta" {
 subnet_id     = aws_subnet.subnet1.id
 route_table_id = aws_route_table.rt.id
}
resource "aws_security_group" "sg" {
 vpc_id = aws_vpc.vpc.id
 ingress {
   from_port   = 22
   to_port     = 22
   protocol    = "tcp"
   cidr_blocks = [var.allowed_ssh_cidr]
   
 }
 ingress {
   from_port   = 80
   to_port     = 80
   protocol    = "tcp"
   cidr_blocks = [var.allowed_ssh_cidr]
   
 }
 egress {
   from_port   = 0
   to_port     = 0
   protocol    = "-1"
   cidr_blocks = ["0.0.0.0/0"]
 }
}