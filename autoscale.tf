resource "aws_autoscaling_attachment" "asg_attachment_bar" {
  autoscaling_group_name = module.eks.eks_managed_node_groups.test-NG.node_group_resources[0].autoscaling_groups[0].name
  alb_target_group_arn   = module.nlb.target_group_arns[0]
}