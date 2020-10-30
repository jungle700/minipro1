#..........................database...................................

resource "aws_db_instance" "default" {
  #count                           = 1
  instance_class         = "db.t2.micro"
  engine                 = "MariaDB"
  engine_version         = "10.4.8"
  vpc_security_group_ids = [aws_security_group.db.id]
  db_subnet_group_name   = aws_db_subnet_group.default.id

  identifier          = var.identifier
  skip_final_snapshot = true
  allocated_storage   = 20
  storage_type        = "gp2"
  multi_az            = false
  #backup_window                   = 
  #backup_retention_period         = 
  name                = var.name
  username            = "admin12"
  password            = "wordpress2020"
  publicly_accessible = false
  storage_encrypted   = false
  apply_immediately   = true
  #enabled_cloudwatch_logs_exports = []


  tags = {
    Environment = "dev"
  }
}

resource "aws_db_subnet_group" "default" {
  name       = "main_subnet_group"
  subnet_ids = [aws_subnet.eu-west-1a-private.id, aws_subnet.eu-west-1a-public.id, aws_subnet.eu-west-1b-public.id, aws_subnet.eu-west-1c-public.id]

  tags = {
    Name = "My DB subnet group"
  }
}

output "database_host" {
  value = aws_db_instance.default.address
}