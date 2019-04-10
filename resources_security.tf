
# ECS tasks security group
resource "aws_security_group" "ecs_tasks_sg" {
  name        = "ecs-tasks-sg"
  description = "Manage traffic rules for the ecs tasks"

  vpc_id      = "${module.network.vpc_id}"


  #Inbound - allow access only from ALB
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    security_groups = ["${module.lb-module.alb_sg_id}"]
  }


  #Outbound - allow internet access for software updates
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}