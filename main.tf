resource "aws_instance" "this" {
  ami                         = data.aws_ami.amazon-linux-2.id
  instance_type               = "c7g.4xlarge"
  associate_public_ip_address = true
  key_name                    = var.key_name
  vpc_security_group_ids      = [aws_security_group.this.id]

  root_block_device {
    delete_on_termination = true
    encrypted             = false
    volume_size           = 100
    volume_type           = "gp3"
  }

  user_data                   = local.cloud_init_content
  user_data_replace_on_change = false

  lifecycle {
    ignore_changes = [
      ami
    ]
  }

  timeouts {
    create = "1m30s"
    delete = "2m"
    update = "2m"
  }

  tags = merge(
    local.tags,
    {
      Name   = "Earthly namada CI"
      Module = "main"
    }
  )
}

resource "aws_eip_association" "eip_assoc" {
  instance_id   = aws_instance.this.id
  allocation_id = var.eip
}

resource "random_uuid" "this" {}

locals {
  cloud_init_content = templatefile("${path.module}/cloud-init.tpl", {
    token = var.earthly_token
    organization = var.earthly_organization
    ip = var.ip
    sat_name = random_uuid.this.result
  })
}

resource "aws_security_group" "this" {
  name        = "Earthly Satellite"
  description = "Security group for earthly satellite"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    local.tags,
    {
      Module = "main"
    }
  )
}
