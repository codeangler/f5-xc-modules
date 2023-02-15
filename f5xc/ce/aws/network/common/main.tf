resource "aws_vpc" "vpc" {
  count                = var.aws_existing_vpc_id == "" ? 1 : 0
  cidr_block           = var.aws_vpc_cidr_block
  enable_dns_support   = var.aws_vpc_enable_dns_support
  enable_dns_hostnames = var.aws_vp_enable_dns_hostnames
  tags                 = var.common_tags
}

module "aws_security_group_slo" {
  source                      = "../../../../../aws/security_group"
  aws_vpc_id                  = aws_vpc.vpc[0].id
  custom_tags                 = var.common_tags
  aws_security_group_name     = format("%s-sg-slo", var.f5xc_cluster_name)
  security_group_rule_egress  = var.aws_security_group_rule_slo_egress
  security_group_rule_ingress = var.aws_security_group_rule_slo_ingress
}

module "aws_security_group_sli" {
  source                      = "../../../../../aws/security_group"
  count                       = var.f5xc_ce_gateway_type == var.f5xc_ce_gateway_type_ingress_egress ? 1 : 0
  aws_vpc_id                  = aws_vpc.vpc[0].id
  custom_tags                 = var.common_tags
  aws_security_group_name     = format("%s-sg-sli", var.f5xc_cluster_name)
  security_group_rule_egress  = var.aws_security_group_rule_sli_egress
  security_group_rule_ingress = var.aws_security_group_rule_sli_ingress
}

resource "aws_internet_gateway" "igw" {
  vpc_id = var.aws_existing_vpc_id != "" ? var.aws_existing_vpc_id : aws_vpc.vpc[0].id
  tags   = var.common_tags
}

resource "aws_route" "route_ipv4" {
  route_table_id         = data.aws_vpc.vpc.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route" "route_ipv6" {
  route_table_id              = data.aws_vpc.vpc.main_route_table_id
  destination_ipv6_cidr_block = "::/0"
  gateway_id                  = aws_internet_gateway.igw.id
}