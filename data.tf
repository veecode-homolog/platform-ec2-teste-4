### DATA IMPORT
data "aws_ami" "amazon-linux" {
  most_recent = true

  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }

  filter {
    name = "name"
    values = ["al2023-*-x86_64"] 
  }
}

data "aws_vpc" "available" {
  tags = var.resource_tags
}

data "aws_subnets" "subnet-public" {
  filter {
    name   = "tag:${local.name_suffix}-public"
    values = ["shared"]
  }
}

data "aws_subnets" "subnet-private" {
  filter {
    name   = "tag:${local.name_suffix}-private"
    values = ["shared"]
  }
}

data "aws_route53_zone" "selected" {
  name         = "${var.host_name}"
  private_zone = false
}
