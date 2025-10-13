resource "aws_vpc" "test_vpc" {
  cidr_block = var.cidr_block
  enable_dns_hostnames = true
  enable_dns_support = true
  tags = {
    Name= var.name
  }
}

resource "aws_subnet" "public_subnet" {
  for_each = {
    for inx, cidr in var.public_subnet_cidr :
    inx => {
      cidr_block        = cidr
      availability_zone = var.availability_zone[inx]
    }
  }

  vpc_id                  = aws_vpc.test_vpc.id
  cidr_block              = each.value.cidr_block
  availability_zone       = each.value.availability_zone
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.name}-${each.value.availability_zone}-public-subnet"
  }
}
resource "aws_subnet" "private_subnet" {
  for_each = {
    for inx, cidr in var.privite_subnet_cidr :
    inx => {
      cidr_block        = cidr
      availability_zone = var.availability_zone[inx]
    }
  }

  vpc_id                  = aws_vpc.test_vpc.id
  cidr_block              = each.value.cidr_block
  availability_zone       = each.value.availability_zone
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.name}-${each.value.availability_zone}-private-subnet"
  }
  
}

resource "aws_internet_gateway" "Iwg" {
  vpc_id = aws_vpc.test_vpc.id
  tags = {
   Name = "${var.name}-Iwg"
  }
}

# resource "aws_route_table" "public_route" {
#   vpc_id = aws_vpc.test_vpc.id
#   tags = {
#     Name = "${var.name}-public_route_table"
#   } 
# }

resource "aws_eip" "nat_ip" {
  domain = "vpc"
  tags = {
    Name = "${var.name}-eip"
  }
}

data "aws_route_table" "default_route_table" {
  vpc_id = aws_vpc.test_vpc.id
  filter {
    name   = "association.main"
    values = ["true"]
  }
} 

resource "aws_route" "Iwg_route" {
  route_table_id = data.aws_route_table.default_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.Iwg.id
}


resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat_ip.id
  //subnet_id = aws_subnet.public_subnet.id[0].id
  subnet_id = values(aws_subnet.public_subnet)[0].id
  tags = {
    Name = "${var.name}-Nat-gateway"
  }
  depends_on = [ aws_internet_gateway.Iwg ]
}

resource "aws_route" "private_route" {
  route_table_id = aws_route_table.private_route_tables.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id =  aws_nat_gateway.nat_gateway.id
}

resource "aws_route_table" "private_route_tables" {
  vpc_id = aws_vpc.test_vpc.id
  tags = {
    Name = "${var.name}-private_route-table"
  }
}
resource "aws_route_table_association" "public_association" {
  for_each = aws_subnet.public_subnet
  subnet_id = each.value.id
  route_table_id = data.aws_route_table.default_route_table.id
}

resource "aws_route_table_association" "private_association" {
  for_each = aws_subnet.private_subnet
  subnet_id = each.value.id
  route_table_id = aws_route_table.private_route_tables.id
  }