# create application load balancer
resource "aws_lb" "application_load_balancer" {
  name               = "${var.record_name}-${var.environment}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["${var.security_groups}"]
  subnets            = [var.dev-pub-main-subnet-id, var.dev-pub-alt-subnet-id]
  enable_deletion_protection = false

  tags   = {
    Name = "${var.record_name}-${var.environment}-alb"
  }
}

# create target group
resource "aws_lb_target_group" "lando_target_group" {
  name        = "app-lando-${var.codigo-pais}-${var.environment}-group"
  target_type = "ip"
  port        = "80"
  protocol    = "HTTP"
  vpc_id      = var.vpc_id

  health_check {
    enabled             = true
    interval            = 300
    path                = "/"
    timeout             = 60
    matcher             = 200
    healthy_threshold   = 5
    unhealthy_threshold = 5
  }

  lifecycle {
    create_before_destroy = true
  }

}

resource "aws_lb_target_group" "checo_target_group" {
  name        = "app-checo-${var.codigo-pais}-${var.environment}-group"
  target_type = "ip"
  port        = "80"
  protocol    = "HTTP"
  vpc_id      = var.vpc_id

  health_check {
    enabled             = true
    interval            = 300
    path                = "/"
    timeout             = 60
    matcher             = 200
    healthy_threshold   = 5
    unhealthy_threshold = 5
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_lb_target_group" "lewis_target_group" {
  name        = "app-lewis-${var.codigo-pais}-${var.environment}-group"
  target_type = "ip"
  port        = "80"
  protocol    = "HTTP"
  vpc_id      = var.vpc_id

  health_check {
    enabled             = true
    interval            = 300
    path                = "/"
    timeout             = 60
    matcher             = 200
    healthy_threshold   = 5
    unhealthy_threshold = 5
  }

  lifecycle {
    create_before_destroy = true
  }
}

# Create a listener on port 80 with redirect action

resource "aws_lb_listener" "alb_http_listener" {
  load_balancer_arn = aws_lb.application_load_balancer.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = 443
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}



# Create a listener on port 443 with forward action
resource "aws_lb_listener" "alb_https_listener" {
  load_balancer_arn  = aws_lb.application_load_balancer.arn
  port               = 443
  protocol           = "HTTPS"
  ssl_policy         = "ELBSecurityPolicy-2016-08"

  certificate_arn = var.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lando_target_group.arn
  }
}

# Create listener on port 443 rules

resource "aws_lb_listener_rule" "lando-rule" {
  listener_arn = aws_lb_listener.alb_https_listener.arn
  priority = 100


  action {
    type = "forward"
    target_group_arn = aws_lb_target_group.lando_target_group.arn
  }

  condition {
    host_header {
      values = ["${var.record_name}-lando-${var.environment}.${var.domain_name}"]
    }
  }
}

resource "aws_lb_listener_rule" "checo-rule" {
  listener_arn = aws_lb_listener.alb_https_listener.arn
  priority = 200

  action {
    type = "forward"
    target_group_arn = aws_lb_target_group.checo_target_group.arn
  }

  condition {
    host_header {
      values = ["${var.record_name}-checo-${var.environment}.${var.domain_name}"]
    }
  }
}

resource "aws_lb_listener_rule" "lewis-rule" {
  listener_arn = aws_lb_listener.alb_https_listener.arn
  priority = 300

  action {
    type = "forward"
    target_group_arn = aws_lb_target_group.lewis_target_group.arn
  }

  condition {
    host_header {
      values = ["${var.record_name}-lewis-${var.environment}.${var.domain_name}"]
    }
  }
}


# Create SSH key for ssh connection

resource "aws_key_pair" "alprestamo" {
  key_name = var.key_name
  public_key = tls_private_key.alprestamo.public_key_openssh
}

 resource "tls_private_key" "alprestamo" {
   algorithm = "RSA"
   rsa_bits = 4096
 }



resource "local_file" "alprestamo" {
   content  = tls_private_key.alprestamo.private_key_pem
   filename = var.key_name
 }


# # create EC2 instance

locals {
  serverconfig = [
    for srv in var.configuration : [
      for i in range(1, srv.no_of_instances+1) : {
        instance_name = "${srv.application_name}"
        instance_type = srv.instance_type
        ami = srv.ami
      }
    ]
  ]
}




// We need to Flatten it before using it

locals {
  instances = flatten(local.serverconfig)
}

resource "aws_instance" "web" {
  for_each = {for server in local.instances: server.instance_name =>  server}
  
  ami           = each.value.ami
  instance_type = each.value.instance_type
  vpc_security_group_ids = ["${var.security_groups}"]

    subnet_id = var.dev-priv-main-subnet-id
  tags = {
    Name = "${each.value.instance_name}-${var.codigo-pais}-${var.environment}"
  }
}


# Attaching EC2 instance to Target Group

resource "aws_alb_target_group_attachment" "lando_attach" {
  target_id        = values(aws_instance.web)[0].private_ip
  target_group_arn = aws_lb_target_group.lando_target_group.arn
  port             = 80
}

resource "aws_alb_target_group_attachment" "checo_attach" {
  target_id        = values(aws_instance.web)[1].private_ip
  target_group_arn = aws_lb_target_group.checo_target_group.arn
  port             = 80
}

resource "aws_alb_target_group_attachment" "lewis_attach" {
  target_id        = values(aws_instance.web)[2].private_ip
  target_group_arn = aws_lb_target_group.lewis_target_group.arn
  port             = 80
}
