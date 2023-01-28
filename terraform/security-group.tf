data "aws_vpc" "default" {
    id = var.vpc_id
}

data "aws_subnet" "selected" {
    id = var.selected_subnet_id
}

resource "aws_security_group" "yview_sg" {
    name        = "yview_sg"
    description = "Manage EC2 traffic"
    vpc_id      = data.aws_vpc.default.id

    ingress {
        from_port        = 22
        to_port          = 22
        protocol         = "tcp"
        cidr_blocks      = ["0.0.0.0/0"]
    }

    ingress {
        from_port        = 80
        to_port          = 80
        protocol         = "tcp"
        cidr_blocks      = ["0.0.0.0/0"]
    }

    egress {
        from_port        = 0
        to_port          = 0
        protocol         = "-1"
        cidr_blocks      = ["0.0.0.0/0"]
    }

}