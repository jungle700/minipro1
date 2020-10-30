#............Nginx 2 nodes server......................................................

resource "aws_instance" "web1" {
  ami                         = var.amis[var.aws_region]
  availability_zone           = "eu-west-1a"
  instance_type               = var.instance_type
  key_name                    = var.aws_key_name
  vpc_security_group_ids      = [aws_security_group.web.id]
  subnet_id                   = aws_subnet.eu-west-1a-public.id
  associate_public_ip_address = true
  #user_data = data.template_file.myuserdata1.template

  tags = {
    Name = "Web_Box1"
  }
}

resource "aws_instance" "web2" {
  ami                         = var.amis[var.aws_region]
  availability_zone           = "eu-west-1b"
  instance_type               = var.instance_type
  key_name                    = var.aws_key_name
  vpc_security_group_ids      = [aws_security_group.web.id]
  subnet_id                   = aws_subnet.eu-west-1b-public.id
  associate_public_ip_address = true
  #user_data = data.template_file.myuserdata1.template

  tags = {
    Name = "Web_Box2"
  }
}


#.........Grafana & Prometheus on Public subnet 1c.............

#........................Grafana&Prometheus on 1 node..............................

resource "aws_instance" "grafprom" {
  ami                         = var.grafprom_ami
  availability_zone           = "eu-west-1c"
  instance_type               = var.instance_type
  key_name                    = var.aws_key_name
  vpc_security_group_ids      = [aws_security_group.grafprom.id]
  subnet_id                   = aws_subnet.eu-west-1c-public.id
  associate_public_ip_address = true
  #user_data = data.template_file.myuserdata1.template

  tags = {
    Name = "grafprom_public"
  }
}

#data "template_file" "myuserdata1" {

#  template = file("${path.cwd}/graf.tpl")

#}

#...........................nat instance..................................

resource "aws_instance" "nat" {
  ami                         = "ami-0bb3fad3c0286ebd5" # this is a special ami preconfigured to do NAT
  availability_zone           = "eu-west-1a"
  instance_type               = var.instance_type
  key_name                    = var.aws_key_name
  vpc_security_group_ids      = [aws_security_group.nat.id]
  subnet_id                   = aws_subnet.eu-west-1a-public.id
  associate_public_ip_address = true
  source_dest_check           = false

  tags = {
    Name = "NAT Instance"
  }
}
  resource "aws_eip" "nat" {
    instance = aws_instance.nat.id
    vpc      = true
  }

# #........................Prometheus..............................

# resource "aws_instance" "prometheus" {
#   ami                         = var.amis[var.aws_region]
#   availability_zone           = "eu-west-1c"
#   instance_type               = var.instance_type
#   key_name                    = var.aws_key_name
#   vpc_security_group_ids      = [aws_security_group.prom.id]
#   subnet_id                   = aws_subnet.eu-west-1c-public.id
#   associate_public_ip_address = true
#   #user_data = data.template_file.myuserdata1.template

#   tags = {
#     Name = "prom_public"
#   }
# }

#data "template_file" "myuserdata1" {

#  template = file("${path.cwd}/graf.tpl")

#}
