# Kubernetes provider
# https://learn.hashicorp.com/terraform/kubernetes/provision-eks-cluster#optional-configure-terraform-kubernetes-provider
# To learn how to schedule deployments and services using the provider, go here: https://learn.hashicorp.com/terraform/kubernetes/deploy-nginx-kubernetes
# The Kubernetes provider is included in this file so the EKS module can complete successfully. Otherwise, it throws an error when creating `kubernetes_config_map.aws_auth`.
# You should **not** schedule deployments and services in this workspace. This keeps workspaces modular (one for provision EKS, another for scheduling Kubernetes resources) as per best practices.
provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
}

provider "aws" {
  region = var.region
}

data "aws_availability_zones" "available" {}

locals {
  cluster_name = "education-eks-${random_string.suffix.result}"
}

resource "random_string" "suffix" {
  length  = 8
  special = false
}

resource "aws_iam_user" "kubernetes" {
  name = "kubernetes"
  path = "/system/"
}

data "aws_iam_policy_document" "example" {
  statement {
    actions   = ["iam:CreateRole"]
    resources = ["*"]
    effect = "Allow"
  }
}

resource "aws_iam_policy" "policy" {
  name        = "Kubernetes-policy"
  description = "My test policy"
  policy      = data.aws_iam_policy_document.example.json
}

resource "aws_iam_user_policy_attachment" "attachment" {
  user       = aws_iam_user.kubernetes.name
  policy_arn = aws_iam_policy.policy.arn
}
