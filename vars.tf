variable "aws_region" {
}

/*
vpc variables
*/

variable "vpc_name" {
  type = string
}

variable "cidr" {
  type = string
  validation {
    condition     = can(regex("^([0-9]{1,3}\\.){3}[0-9]{1,3}($|/(16))$", var.cidr))
    error_message = "Vpc_cidr value must be greater than 172.0.0.0/16."
  }
}

variable "azs" {
  type = list(string)
}

variable "public_subnets" {
  type = list(string)
}

variable "private_subnets" {
  type = list(string)
}

variable "vpc_tags" {
  type = map(string)  
}

/*
launch templates
*/

variable "instance_types" {
  description = "Instance types"
  # Smallest recommended, where ~1.1Gb of 2Gb memory is available for the Kubernetes pods after ‘warming up’ Docker, Kubelet, and OS
  type    = list(string)
  default = ["t3.xlarge"]
}

/*
oidc
*/

variable "k8s_namespace" {
  type = string
}

variable "role_name" {
  type = string
}

variable "policy_name" {
  type = string
}

variable "iam_user" {
  type = string
}

# rbac

variable "map_users" {
  description = "Additional IAM users to add to the aws-auth configmap."
  type        = list(map(string))
}