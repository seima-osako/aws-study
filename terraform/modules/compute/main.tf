############################
# EC2 Instance
############################
resource "aws_instance" "app_server" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_name
  subnet_id              = var.public_subnet_ids[0]
  vpc_security_group_ids = [var.ec2_sg_id]

  tags = {
    Name        = "${var.prefix}-ec2"
    Environment = "lab"
    Project     = var.prefix
  }
}

############################
# Target Group (HTTP:8080)
############################
resource "aws_lb_target_group" "app_tg" {
  name        = "${var.prefix}-tg"
  port        = 8080
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = var.vpc_id

  health_check {
    path                = "/"
    healthy_threshold   = 5
    unhealthy_threshold = 2
    matcher             = "200"
  }

  tags = {
    Name = "${var.prefix}-tg"
  }
}

############################
# Attachment: TG → EC2
############################
resource "aws_lb_target_group_attachment" "tg_to_app" {
  target_group_arn = aws_lb_target_group.app_tg.arn
  target_id        = aws_instance.app_server.id
  port             = 8080
}

############################
# Application Load Balancer
############################
resource "aws_lb" "app_alb" {
  name                       = "${var.prefix}-alb"
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = [var.alb_sg_id]
  subnets                    = var.public_subnet_ids
  enable_deletion_protection = false

  tags = {
    Name = "${var.prefix}-alb"
  }
}

############################
# Listener : port 80 → TG
############################
resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.app_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_tg.arn
  }
}
