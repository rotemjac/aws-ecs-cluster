
# ------------ Services ------------ #
resource "aws_ecs_service" "my-service" {
  name            = "my-service"
  cluster         = "${aws_ecs_cluster.my-cluster.id}"
  task_definition = "${aws_ecs_task_definition.web-server-task.arn}"

  launch_type     = "FARGATE"
  desired_count   = 2

  network_configuration {
    security_groups  = ["${aws_security_group.ecs_tasks_sg.id}"]
    subnets          = ["${module.network.public_subnets}"]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = "${module.lb-module.alb_target_group_arn}"
    container_name   = "${var.container_name}"
    container_port   = "${var.web_server_port}"
  }

  depends_on = ["aws_ecs_task_definition.web-server-task",]
}



module "lb-module" {
  source = "Modules/load_balancing"

  vpc_id  = "${module.network.vpc_id}"
  subnets = "${module.network.public_subnets}"

  lb_protocol = "HTTP"
  lb_port     = 80

  lb_target_group_protocol = "HTTP"
  lb_target_group_port     = 80

  lb_sg_from_port = 80
  lb_sg_to_port   = 80
}





module "network" {
  source = "Modules/vpc"
  cidr   = "10.0.0.0/16"
  azs    = "${var.azs}"
  number_of_private_subnets = 0
  number_of_public_subnets  = 2
}