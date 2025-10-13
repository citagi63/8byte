
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