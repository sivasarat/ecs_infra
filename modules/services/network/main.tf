# VPC
resource "aws_vpc" "demo_vpc" {
  cidr_block = var.vpc_cidr

  tags = merge({
    Name = "demo_vpc"
  }, local.common_tags)
}

# INTERNET GATEWAY
resource "aws_internet_gateway" "demo_igw" {
  vpc_id = aws_vpc.demo_vpc.id

  tags = merge({
    Name = "demo_igw"
  }, local.common_tags)
}

# PUBLIC SUBNET
resource "aws_subnet" "public_subnet" {
  count = var.resource_count
  vpc_id                  = aws_vpc.demo_vpc.id
  cidr_block              = var.public_cidr
  map_public_ip_on_launch = true

  tags = merge({
    Name = "demo-public-subnet-${count.index}"
  }, local.common_tags)
}

# PUBLIC ROUTE TABLE
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.demo_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.demo_igw.id
  }

  tags = merge({
    Name = "demo_public_route_table"
  }, local.common_tags)
}

# NAT GATEWAY
resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.demo_nat_ip.id
  subnet_id     = aws_subnet.public_subnet.id

  tags = merge({
    Name = "demo_nat_gw"
  }, local.common_tags)
}

# ROUTE TABLE ASSOCIATION - PUBLIC
resource "aws_route_table_association" "public_route_assoc" {
  count = var.resource_count
  subnet_id      = aws_subnet.public_subnet[count.index].id
  route_table_id = aws_route_table.public_route_table.id
}


# ELASTIC IP
resource "aws_eip" "demo_nat_ip" {
  vpc = true
  tags = merge({ Name = "demo_nat_EIP"
  }, local.common_tags)
}

# PRIVATE SUBNET
resource "aws_subnet" "private_subnet" {
  count = var.resource_count
  vpc_id     = aws_vpc.demo_vpc.id
  cidr_block = var.private_cidr

  tags = merge({
    Name = "demo-private-subnet-${count.index}"
  }, local.common_tags)
}

# PRIVATE ROUTE TABLE
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.demo_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat_gw.id
  }

  tags = merge({
    Name = "demo_private_route_table"
  }, local.common_tags)
}

# ROUTE TABLE ASSOCIATION - PRIVATE
resource "aws_route_table_association" "private_route_assoc" {
  count = var.resource_count
  subnet_id      = aws_subnet.private_subnet[count.index].id
  route_table_id = aws_route_table.private_route_table.id
}
