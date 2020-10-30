variable "aws_region" {
  description = "AWS region to launch servers."
  default     = "eu-west-1"

}


variable "vpc_cidr" {
  description = "CIDR for the whole VPC"
  default     = "10.9.0.0/16"
}

variable "public_1a_subnet_cidr" {
  description = "CIDR for the Public 1a Subnet"
  default     = "10.9.1.0/24"
}


variable "public_1b_subnet_cidr" {
  description = "CIDR for the Public Subnet"
  default     = "10.9.2.0/24"
}

variable "public_1c_subnet_cidr" {
  description = "CIDR for the Public Subnet"
  default     = "10.9.3.0/24"
}

variable "private_1a_subnet_cidr" {
  description = "CIDR for the Public Subnet"
  default     = "10.9.4.0/24"
}

variable "amis" {
  type = map(string)
  default = {
    "eu-west-1" = "ami-05f9d7a5751527d33"
  }
}

variable "grafprom_ami" {
  default = "ami-0aa8da7c77bb02b09"
  }

variable "instance_type" {
  default = "t2.micro"
}

variable "aws_key_name" {
  default = "jaye"
}

variable "name" {
  default = "week5db"
}

variable "identifier" {
  default = "week5db"
}