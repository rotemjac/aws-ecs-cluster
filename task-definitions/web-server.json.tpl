[
  {
    "name": "${container_name}",
    "image": "${web_server_image}",


    "portMappings": [
      {
        "containerPort" : ${web_server_port},
        "hostPort"      : ${web_server_port}
      }
    ],

    "essential": true
  }
]