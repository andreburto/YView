resource "aws_key_pair" "deployer" {
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_instance" "yview_instance" {
    ami             = data.aws_ami.amznlnx2.id
    associate_public_ip_address = true
    instance_type   = "t3.small"
    key_name        = aws_key_pair.deployer.key_name
    subnet_id       = data.aws_subnet.selected.id
    security_groups = [aws_security_group.yview_sg.id]
    user_data       = file("userdata.sh")
}
