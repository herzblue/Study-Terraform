resource "aws_lb" "ygpark-alb" {
  name               = "ygpark-t101-alb"
  load_balancer_type = "application"
  subnets            = [aws_subnet.ygpark-subnet1.id, aws_subnet.ygpark-subnet2.id]
  security_groups = [aws_security_group.ygpark-sg.id]

  tags = {
    Name = "ygpark-t101-alb"
  }
}

resource "aws_lb_listener" "ygpark-http" {
  load_balancer_arn = aws_lb.ygpark-alb.arn
  port              = 80
  protocol          = "HTTP"

  # By default, return a simple 404 page
  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "404: page not found - T101 Study"
      status_code  = 404
    }
  }
}

resource "aws_lb_target_group" "ygpark-albtg" {
  name = "ygpark-t101-alb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.ygpark-vpc.id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200-299"
    interval            = 5
    timeout             = 3
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

resource "aws_lb_listener_rule" "ygpark-albrule" {
  listener_arn = aws_lb_listener.ygpark-http.arn
  priority     = 100

  condition {
    path_pattern {
      values = ["*"]
    }
  }

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ygpark-albtg.arn
  }
}

output "ygpark-alb_dns" {
  value       = aws_lb.ygpark-alb.dns_name
  description = "The DNS Address of the ALB"
}

