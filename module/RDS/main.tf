resource "aws_db_subnet_group" "aws_db_subnet_group" {
  name = var.name
  subnet_ids = var.subnet_ids
  tags = {
    Name = "${var.name}-db_subnet_group"
  }
}

resource "aws_db_instance"  "aws_db_instance" {
  allocated_storage = 20
  storage_type = "gp2"
  engine = "mysql"
  engine_version = "8.0.42"
  instance_class = "db.t4g.micro"
  identifier = "${var.name}-db"
  username = "dbuser"
  password = "dbpassword"

  vpc_security_group_ids = var.db-security_group_id
  db_subnet_group_name = aws_db_subnet_group.aws_db_subnet_group.name

  skip_final_snapshot = true
}