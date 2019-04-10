resource "aws_ecs_cluster" "my-cluster" {
  name = "my-cluster"
}


# ------------ Tasks ------------ #
resource "aws_ecs_task_definition" "web-server-task" {
  family                   = "web-server-task"

  network_mode             = "awsvpc"

  requires_compatibilities = ["FARGATE"]
  cpu                      = "1024" # (1 vCPU)
  memory                   = "2048" #(In MiB)
  container_definitions    = "${data.template_file.ws-container-def.rendered}"

  #If you want the task to pull container images or log to cloudWatch
  execution_role_arn       = "${data.aws_iam_role.ecs_task_execution_role.arn}"
}

data "template_file" "ws-container-def" {
  template = "${file("task-definitions/web-server.json.tpl")}"

  vars {
    web_server_image = "nginx"
    web_server_port  = "${var.web_server_port}"
    container_name   = "${var.container_name}"
  }
}

data "aws_iam_role" "ecs_task_execution_role" {
  name = "ecsTaskExecutionRole"
}