
variable "web_server_port" {
  description = "Port exposed by container"
  default     = 80
}

variable "container_name" {
  default = "web-server"
}

variable "ecs_task_execution_role" {
  description = "Role arn for the ecsTaskExecutionRole"
  default     = "arn:aws:iam::309154556741:role/ecsTaskExecutionRole"
}

variable "ecs_autoscale_role" {
  description = "Role arn for the ecsAutocaleRole"
  default     = "arn:aws:iam::309154556741:role/ecsAutoscaleRoles"
}



