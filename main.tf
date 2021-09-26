# data loaded from EKS module main
data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}

#The Availability Zones data source allows access to the list of 
#AWS Availability Zones which can be accessed by an AWS account 
#within the region configured in the provider.

data "aws_availability_zones" "available" {
}

data "aws_caller_identity" "current" {
}

locals {
  cluster_name = "tfekslab-${random_string.suffix.result}"
}
resource "random_string" "suffix" {
  length  = 8
  special = false
}

module vpc {
  source  = "terraform-aws-modules/vpc/aws"
  version = "v3.7.0"

  
  name            = var.vpc_name
  cidr            = var.cidr 
  azs             = var.azs
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets

  # Have one NAT Gateway per AZ to give private subnets access to the external internet
  enable_nat_gateway     = true
  single_nat_gateway     = false
  one_nat_gateway_per_az = true

  # Support VPC Flow Logs
  enable_flow_log                      = true
  create_flow_log_cloudwatch_log_group = true
  create_flow_log_cloudwatch_iam_role  = true
  flow_log_max_aggregation_interval    = 60

  tags = var.vpc_tags

    private_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared" # EKS adds this and TF would want to remove then later
  }
}

module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = local.cluster_name
  cluster_version = "1.20"
  subnets         = module.vpc.private_subnets
  vpc_id          = module.vpc.vpc_id
  enable_irsa     = true
  cluster_endpoint_private_access = true
  cluster_endpoint_public_access = true
  node_groups = {
    worker = {
      desired_capacity = 3
      max_capacity     = 15
      min_capacity     = 3

      launch_template_id      = aws_launch_template.default.id
      launch_template_version = aws_launch_template.default.default_version

      instance_types = var.instance_types

      additional_tags = {
        CustomTag = "EKS example"
      }
    }
  }
  map_users = var.map_users
}