# Create RDB Subnet Group

resource "aws_db_subnet_group" "subnet-group" {
    name = "db-${var.record_name}-${var.codigo-pais}-${var.environment}"
    subnet_ids = [var.dev-priv-main-subnet-id, var.dev-priv-alt-subnet-id]
    vpc_id = var.vpc_id

    tags = {
      Name = "db-${var.record_name}-${var.codigo-pais}-${var.environment}"
    }
}

resource "aws_db_instance" "alprestamo-rds" {
    count = 1
    allocated_storage = 20
    db_name = "${var.record_name}"
    engine = var.engine
    engine_version = var.engine-version
    instance_class = var.db-instance-class
    username = "${var.record_name}"
    password = "${var.db-password}"
    db_subnet_group_name = aws_db_subnet_group.subnet-group.name
    skip_final_snapshot = true
    max_allocated_storage = 1000
}