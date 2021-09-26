vpc_name = "demo-vpc"
aws_region = "us-east-2"
cidr       = "10.0.0.0/16"
azs        = ["us-east-2a", "us-east-2b", "us-east-2c"]
public_subnets  = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
private_subnets = ["10.0.17.0/24", "10.0.18.0/24", "10.0.19.0/24"]
vpc_tags = {
  "Terraform" = "true"
  Environment = "Dev"
}