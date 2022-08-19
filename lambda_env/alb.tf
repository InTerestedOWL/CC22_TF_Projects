locals {
  resource_name             = trimsuffix(substr("${local.prefix}-lambda", 0, 32), "-")
  alb_arn                   = aws_lb.web.arn
  alb_sg                    = module.alb_sg.security_group_id
}

# ------- ALB Security Group Rule --------

module "web_http_sg" {
  source = "terraform-aws-modules/security-group/aws"

  create_sg           = false
  security_group_id   = local.alb_sg
  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = [
    "http-80-tcp",
    "https-443-tcp"
  ]
  egress_rules        = ["http-80-tcp"]
}

# ------- ALB Listener --------

resource "aws_lb_listener" "web_http" {
  load_balancer_arn = local.alb_arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_lb_listener" "web_https" {
  load_balancer_arn = local.alb_arn
  port              = 443
  protocol          = "HTTPS"
  certificate_arn = aws_acm_certificate_validation.my_domain.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lambda.arn
  }
}

# ------- ALB Lambda Target Group --------

resource "aws_lb_target_group" "lambda" {
  name        = local.resource_name
  target_type = "lambda"

  tags = merge(
    {
      Name = local.resource_name
    },
    local.common_tags
  )
}

resource "aws_lambda_permission" "alb" {
  statement_id  = "AllowExecutionFromALB"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.password_generator.arn
  principal     = "elasticloadbalancing.amazonaws.com"
  source_arn    = aws_lb_target_group.lambda.arn
}

resource "aws_lb_target_group_attachment" "alb" {
  target_group_arn = aws_lb_target_group.lambda.arn
  target_id        = aws_lambda_function.password_generator.arn
  depends_on       = [aws_lambda_permission.alb]
}

resource "aws_route53_record" "alb" {
  zone_id = data.aws_route53_zone.my_domain.zone_id
  name    = local.domain_name
  type    = "A"

  alias {
    name                   = aws_lb.web.dns_name
    zone_id                = aws_lb.web.zone_id
    evaluate_target_health = true
  }
}

resource "aws_lb" "web" {
  name            = "${local.prefix}-alb"
  subnets         = module.vpc.public_subnets
  security_groups = [module.alb_sg.security_group_id]

  tags = merge(
    {
      Name = "${local.prefix}-alb"
    },
    local.common_tags
  )
}

module "alb_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "${local.prefix}-alb-sg"
  description = "Security group for ALB"
  vpc_id      = module.vpc.vpc_id

  egress_rules = ["all-all"]
}
