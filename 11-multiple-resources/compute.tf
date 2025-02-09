locals {
  ami_ids = {
    ubuntu = data.aws_ami.ubuntu_eu.id
    nginx  = data.aws_ami.nginx.id
  }
}

data "aws_ami" "ubuntu_eu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-*-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

data "aws_ami" "nginx" {
  most_recent = true

  filter {
    name   = "name"
    values = ["bitnami-nginx-1.27.4-linux-debian-12-x86_64-hvm-ebs-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "from_count" {
  count         = var.ec2_instance_count
  ami           = data.aws_ami.ubuntu_eu.id
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.main[count.index % length(aws_subnet.main)].id

  tags = {
    Project = local.project
    Name    = "${local.project}-${count.index}"
  }
}


resource "aws_instance" "from_config" {
  count         = var.ec2_instance_count
  ami           = data.aws_ami.ubuntu_eu.id
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.main[count.index % length(aws_subnet.main)].id

  tags = {
    Project = local.project
    Name    = "${local.project}-${count.index}"
  }
}

resource "aws_instance" "from_list" {
  count         = length(var.ec2_instance_config_list)
  ami           = local.ami_ids[var.ec2_instance_config_list[count.index].ami]
  instance_type = var.ec2_instance_config_list[count.index].instance_type
  subnet_id     = aws_subnet.main["default"].id

  tags = {
    Project = local.project
    Name    = "${local.project}-${count.index}"
  }
}

resource "aws_instance" "from_map" {
  # each.key => holds the key of the map
  # each.value => holds the value each key-value pair of the  map
  for_each = var.ec2_instance_config_map

  ami           = local.ami_ids[each.value.ami]
  instance_type = each.value.instance_type
  subnet_id     = aws_subnet.main[each.value.subnet_name].id

  tags = {
    Project = local.project
    Name    = "${local.project}-${each.key}"
  }
}
