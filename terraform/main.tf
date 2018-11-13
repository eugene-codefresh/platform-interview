resource "aws_ecs_cluster" "cluster" {
  name = "${var.ecs-cluster-name}"
}

data "template_file" "platform_task" {
  template = "${file("${path.root}/tasks/platform.json")}"

  vars {
    image           = "${var.registry_url}"
  }
}

resource "aws_ecs_task_definition" "platform" {
  family                   = "platform"
  container_definitions    = "${data.template_file.platform_task.rendered}"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"
}

data "aws_ecs_task_definition" "platform" {
  task_definition = "${aws_ecs_task_definition.platform.family}"
  depends_on      = ["aws_ecs_task_definition.platform"]
}

resource "aws_ecs_service" "platform" {
  name            = "platform"
  task_definition = "${aws_ecs_task_definition.platform.family}:${max("${aws_ecs_task_definition.platform.revision}", "${data.aws_ecs_task_definition.platform.revision}")}"
  desired_count   = 1
  launch_type     = "FARGATE"
  cluster =       "${aws_ecs_cluster.cluster.id}"
}