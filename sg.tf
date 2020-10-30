#..........................................grafprom_security_group........................................................ 

resource "aws_security_group" "grafprom" {
  name        = "grafana_SG"
  description = "Allow incoming HTTP connections."

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 9090
    to_port     = 9090
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 9100
    to_port     = 9100
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  vpc_id = aws_vpc.default.id

  tags = {
    Name = "grafprom_public_SG"
  }
}

#..........................................prometheus_security_group........................................................ 

# resource "aws_security_group" "prom" {
#   name        = "prometheus_SG"
#   description = "Allow incoming HTTP connections."

#   ingress {
#     from_port       = 22
#     to_port         = 22
#     protocol        = "tcp"
#     security_groups = [aws_security_group.grafana.id]

#   }
#   ingress {
#     from_port       = 9090
#     to_port         = 9090
#     protocol        = "tcp"
#     security_groups = [aws_security_group.grafana.id]
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#   vpc_id = aws_vpc.default.id
#   tags = {
#     Name = "Prometheus_Private_SG"
#   }
# }

#..........................................web_security_group........................................................ 

resource "aws_security_group" "web" {
  name        = "web"
  description = "Allow incoming HTTP connections."

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

   ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }
  ingress {
    from_port   = 9100
    to_port     = 9100
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  vpc_id = aws_vpc.default.id
  tags = {
    Name = "Prometheus_Private_SG"
  }
}

#........................database_security_group......................................

resource "aws_security_group" "db" {
  name        = "vpc_db"
  description = "Allow incoming database connections."

  ingress { # MySQL
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.web.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }


  vpc_id = aws_vpc.default.id

  tags = {
    Name = "DBServerSG"
  }
}

#.................................nat instance SG........................................................................

resource "aws_security_group" "nat" {
  name        = "vpc_nat"
  description = "Allow traffic to pass from the private subnet to the internet"

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.web.id]

  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  vpc_id = aws_vpc.default.id

  tags = {
    Name = "NATSG"
  }
}