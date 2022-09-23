locals {
  min_instance      = 2
  max_instance      = 5
  lc_resource_name     = trimsuffix(substr("${local.prefix}-nginx-asg", 0, 32), "-")
}


resource "aws_launch_configuration" "web" {
  name_prefix = local.lc_resource_name

  image_id      = local.ec2_ami # ubuntu 20.04 AMI (HVM), SSD Volume Type
  instance_type = local.ec2_instance_type

  security_groups             = [module.instance_sg.security_group_id]
  associate_public_ip_address = true

  user_data = <<-EOF
#!/bin/bash
apt update
apt -y install nginx
chkconfig nginx on
service nginx start
  EOF

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "web" {
  name = local.resource_name

  min_size         = local.min_instance
  desired_capacity = local.min_instance
  max_size         = local.max_instance

  health_check_type = "ELB"

  target_group_arns    = [aws_lb_target_group.web.arn]
  launch_configuration = aws_launch_configuration.web.name

  metrics_granularity = "1Minute"

  vpc_zone_identifier = module.vpc.public_subnets

  lifecycle {
    create_before_destroy = true
  }

  tag {
    key                 = "Name"
    value               = local.resource_name
    propagate_at_launch = true
  }

}