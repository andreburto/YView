data "aws_ami" "amznlnx2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name      = "owner-alias"
    values    = ["amazon"]
  }

  filter {
    name      = "name"
    values    = ["amzn2-ami-hvm-*-x86_64-ebs"]
  }
}

