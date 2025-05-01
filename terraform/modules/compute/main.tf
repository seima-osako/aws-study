resource "aws_instance" "app" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_name
  subnet_id              = var.public_subnet_ids[0]
  vpc_security_group_ids = [var.ec2_sg_id]

  tags = {
    Name        = "${var.prefix}-ec2"
    Environment = "dev"
    Project     = var.prefix
  }
}
