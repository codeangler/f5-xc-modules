output "aws_eks" {
  value = {
    "id"                        = aws_eks_cluster.eks.id
    "name"                      = aws_eks_cluster.eks.name
    "tags"                      = aws_eks_cluster.eks.tags
    "vpc_id"                    = module.aws_vpc.aws_vpc["id"]
    "version"                   = aws_eks_cluster.eks.version
    "vpc_config"                = aws_eks_cluster.eks.vpc_config
    "node_group_id"             = aws_eks_node_group.eks.id
    "platform_version"          = aws_eks_cluster.eks.platform_version
    "kubernetes_network_config" = aws_eks_cluster.eks.kubernetes_network_config
    "subnets"                   = {
      format("%s-snet-a", var.aws_eks_cluster_name) = {
        "id"     = module.aws_subnets.aws_subnets[format("%s-snet-a", var.aws_eks_cluster_name)]["id"]
        "vpc_id" = module.aws_subnets.aws_subnets[format("%s-snet-a", var.aws_eks_cluster_name)]["vpc_id"]
      }
      format("%s-snet-b", var.aws_eks_cluster_name) = {
        "id"     = module.aws_subnets.aws_subnets[format("%s-snet-b", var.aws_eks_cluster_name)]["id"]
        "vpc_id" = module.aws_subnets.aws_subnets[format("%s-snet-b", var.aws_eks_cluster_name)]["vpc_id"]
      }
    }
    subnet_ids = [for s in module.aws_subnets.aws_subnets : s["id"]]
  }
}