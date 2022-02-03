output "eks_managed_node_groups" {
    value =module.eks.eks_managed_node_groups
}


output "http_tcp_listener_arns" {
    value =module.nlb.http_tcp_listener_arns
}
output "http_tcp_listener_ids" {
    value =module.nlb.http_tcp_listener_ids
}
output "https_listener_arns" {
    value =module.nlb.https_listener_arns
}
output "https_listener_ids" {
    value =module.nlb.https_listener_ids
}
output "lb_arn" {
    value =module.nlb.lb_arn
}
output "lb_arn_suffix" {
    value =module.nlb.lb_arn_suffix
}
output "lb_dns_name" {
    value =module.nlb.lb_dns_name
}
output "lb_id" {
    value =module.nlb.lb_id
}
output "lb_zone_id" {
    value =module.nlb.lb_zone_id
}
output "target_group_arn_suffixes" {
    value =module.nlb.target_group_arn_suffixes
}
output "target_group_arns" {
    value =module.nlb.target_group_arns
}
output "target_group_attachments" {
    value =module.nlb.target_group_attachments
}

output "target_group_names" {
    value =module.nlb.target_group_names
}


output "aws_autoscaling_attachment" {
    value = aws_autoscaling_attachment.asg_attachment_bar.autoscaling_group_name
}
output "elb" {
    value = aws_autoscaling_attachment.asg_attachment_bar.elb
}
output "alb_target_group_arn" {
    value = aws_autoscaling_attachment.asg_attachment_bar.alb_target_group_arn
}