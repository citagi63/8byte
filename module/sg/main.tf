
resource "aws_security_group" "eks_cluster" {
  name        = "${var.sg-name}-cluster-sg"
  description = "Security group for EKS cluster control plane"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks =  var.cidr
    description = "Allow EKS control plane access from within VPC"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic from EKS control plane"
  }

  tags = merge(
    {
      Name = "${var.sg-name}-cluster-sg"
    }
  )
}

resource "aws_security_group" "eks_worker_nodes" {
  name        = "${var.sg-name}-worker-nodes-sg"
  description = "Security group for EKS worker nodes"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    self        = true
    description = "Allow worker nodes to communicate with each other"
  }

  ingress {
    from_port       = 0
    to_port         = 65535
    protocol        = "tcp"
    security_groups = [aws_security_group.eks_cluster.id]
    description     = "Allow worker nodes to communicate with EKS control plane"
  }

  ingress {
    from_port   = 1025
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = var.cidr
    description = "Allow pods to communicate with the cluster API Server"
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow HTTPS traffic from anywhere"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }

  tags = merge(
    {
      Name = "${var.sg-name}-worker-nodes-sg"
    }
  )
}


resource "aws_security_group" "rds_sg_group" {
  name        =  "${var.sg-name}-sg"
  description = "Allow inbound traffic"
  vpc_id      = var.vpc_id
  tags = {
    Name =  "${var.sg-name}-db-sg"
  }
}

resource "aws_vpc_security_group_egress_rule" "rds_allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.rds_sg_group.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

resource "aws_vpc_security_group_ingress_rule" "rds_allow_http_ipv4" {
  security_group_id = aws_security_group.rds_sg_group.id
  referenced_security_group_id = aws_security_group.eks_worker_nodes.id
  from_port         = 3306
  ip_protocol       = "tcp"
  to_port           = 3306
}