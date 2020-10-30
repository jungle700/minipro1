resource "aws_vpc" "default" {

  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  tags = {
    Name = "Ansible-aws-vpc"
  }
}

#.................internet gateway..............................

resource "aws_internet_gateway" "default" {

  vpc_id = aws_vpc.default.id

}

#.................nat gateway...................................

# resource "aws_eip" "natgw_1a" {

#   vpc = true
# }

# resource "aws_nat_gateway" "gw" {
#   allocation_id = aws_eip.natgw_1a.id
#   subnet_id     = aws_subnet.eu-west-1a-public.id

#   tags = {
#     Name = "Private_1a NAT"
#   }
# }


#...............key pair....................................

#resource "aws_key_pair" "tkay" {

#  key_name = "tkay"

#  public_key = file(var.path_to_public_key)

#}

#..............................Availability Zone 1a.....................................................

#...............route table.....................................

resource "aws_route_table" "eu-west-1a-public" {
  vpc_id = aws_vpc.default.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.default.id
  }

  tags = {
    Name = "Public_1a_route_table"
  }
}

resource "aws_route_table" "eu-west-1b-public" {
  vpc_id = aws_vpc.default.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.default.id
  }

  tags = {
    Name = "Public_1b_route_table"
  }
}

resource "aws_route_table" "eu-west-1c-public" {
  vpc_id = aws_vpc.default.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.default.id
  }

  tags = {
    Name = "Public_1c_route_table"
  }
}

#............................nat instance route table.........................

resource "aws_route_table" "eu-west-1a-private" {
  vpc_id = aws_vpc.default.id

  route {
    cidr_block  = "0.0.0.0/0"
    instance_id = aws_instance.nat.id
  }

  tags = {
    Name = "Private_1a_route_table"
  }
}



#.............route table associations........................



resource "aws_route_table_association" "eu-west-1a-public" {
  subnet_id      = aws_subnet.eu-west-1a-public.id
  route_table_id = aws_route_table.eu-west-1a-public.id
}

resource "aws_route_table_association" "eu-west-1b-public" {
  subnet_id      = aws_subnet.eu-west-1b-public.id
  route_table_id = aws_route_table.eu-west-1b-public.id
}

resource "aws_route_table_association" "eu-west-1c-public" {
  subnet_id      = aws_subnet.eu-west-1c-public.id
  route_table_id = aws_route_table.eu-west-1c-public.id
}


resource "aws_route_table_association" "eu-west-1a-private" {
  subnet_id      = aws_subnet.eu-west-1a-private.id
  route_table_id = aws_route_table.eu-west-1a-private.id
}





#.............subnets.......................................

resource "aws_subnet" "eu-west-1a-private" {
  vpc_id = aws_vpc.default.id

  cidr_block        = var.private_1a_subnet_cidr
  availability_zone = "eu-west-1a"

  tags = {
    Name = "Private_1a_Subnet"
  }
}



resource "aws_subnet" "eu-west-1a-public" {
  vpc_id = aws_vpc.default.id

  cidr_block        = var.public_1a_subnet_cidr
  availability_zone = "eu-west-1a"

  tags = {
    Name = "Public_1a_Subnet"
  }
}


resource "aws_subnet" "eu-west-1b-public" {
  vpc_id = aws_vpc.default.id

  cidr_block        = var.public_1b_subnet_cidr
  availability_zone = "eu-west-1b"

  tags = {
    Name = "Public_1b_Subnet"
  }
}

resource "aws_subnet" "eu-west-1c-public" {
  vpc_id = aws_vpc.default.id

  cidr_block        = var.public_1c_subnet_cidr
  availability_zone = "eu-west-1c"

  tags = {
    Name = "Public_1c_Subnet"
  }
}


