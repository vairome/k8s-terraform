#
# VPC Resources
#  * VPC

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = tomap({
    "Name"                                      = "terraform-eks-pern-${terraform.workspace}",
    "kubernetes.io/cluster/${var.cluster-name}" = "shared",
  })
}


