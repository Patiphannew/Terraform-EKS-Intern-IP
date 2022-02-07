variable "eks" {
  type = map
}
variable "eksSubnet" {
  type = list
}
variable "eksManagedNodeGroupDefaults" {
  type = map
}
variable "eksManagedNodeGroup" {
  type = map
}

module "eks" {
  source = "terraform-aws-modules/eks/aws"

  cluster_name                    = var.eks.cluster_name
  cluster_version                 = var.eks.cluster_version
  cluster_endpoint_private_access = var.eks.cluster_endpoint_private_access
  cluster_endpoint_public_access  = var.eks.cluster_endpoint_public_access

  #   cluster_addons = {
  #     coredns = {
  #       resolve_conflicts = "OVERWRITE"
  #     }
  #     kube-proxy = {}
  #     vpc-cni = {
  #       resolve_conflicts = "OVERWRITE"
  #     }
  #   }

  #   cluster_encryption_config = [{
  #     provider_key_arn = "ac01234b-00d9-40f6-ac95-e42345f78b00"
  #     resources        = ["secrets"]
  #   }]

  vpc_id     = var.eks.vpc_id
  subnet_ids = [var.eksSubnet[0], var.eksSubnet[1], var.eksSubnet[2]]

  ##################################################################################################################




  # # Self Managed Node Group(s)
  # self_managed_node_group_defaults = {
  #   instance_type                          = "t3.medium"
  #   update_launch_template_default_version = true
  #   iam_role_additional_policies           = ["arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"]
  # }

  # self_managed_node_groups = {
  #   one = {
  #     name = "banjo_selfmanagednode3"

  #     public_ip    = true
  #     max_size     = 3
  #     desired_size = 1

  #     use_mixed_instances_policy = true
  #     mixed_instances_policy = {
  #       instances_distribution = {
  #         on_demand_base_capacity                  = 0
  #         on_demand_percentage_above_base_capacity = 10
  #         spot_allocation_strategy                 = "capacity-optimized"
  #       }

  #       # override = [
  #       #   {
  #       #     instance_type     = "t3.medium"
  #       #     weighted_capacity = "1"
  #       #   },
  #       #   {
  #       #     instance_type     = "t3.medium"
  #       #     weighted_capacity = "2"
  #       #   },
  #       # ]
  #     }

  #     pre_bootstrap_user_data = <<-EOT
  #     echo "foo"
  #     export FOO=bar
  #     EOT

  #     bootstrap_extra_args = "--kubelet-extra-args '--node-labels=node.kubernetes.io/lifecycle=spot'"

  #     post_bootstrap_user_data = <<-EOT
  #     cd /tmp
  #     sudo yum install -y https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm
  #     sudo systemctl enable amazon-ssm-agent
  #     sudo systemctl start amazon-ssm-agent
  #     EOT
  #   }
  # }


  ##################################################################################################################



  # EKS Managed Node Group(s)
  eks_managed_node_group_defaults = {
    ami_type       = var.eksManagedNodeGroupDefaults.ami_type
    disk_size      = var.eksManagedNodeGroupDefaults.disk_size
    instance_types = [var.eksManagedNodeGroupDefaults.instance_types]
    # vpc_security_group_ids = [aws_security_group.additional.id]
    vpc_security_group_ids = [var.eksManagedNodeGroupDefaults.vpc_security_group_ids]
  }

  eks_managed_node_groups = {
    # name = "banjo_managednode3"
    # blue = {}
    (var.eksManagedNodeGroup.name) = {
      # create_launch_template = false
      # launch_template_name   = ""
      min_size     = var.eksManagedNodeGroup.min_size
      max_size     = var.eksManagedNodeGroup.max_size
      desired_size = var.eksManagedNodeGroup.desired_size

      instance_types = [var.eksManagedNodeGroup.instance_types]
      # capacity_type  = "SPOT"
      capacity_type = var.eksManagedNodeGroup.capacity_type
    }

    # green = {
    #   name = "banjo_managednode3"
    #   min_size     = 1
    #   max_size     = 2
    #   desired_size = 1

    #   instance_types = ["t3.medium"]
    #   capacity_type  = "SPOT"
    #   labels = {
    #     Environment = "test"
    #     GithubRepo  = "terraform-aws-eks"
    #     GithubOrg   = "terraform-aws-modules"
    #   }
    #   taints = {
    #     dedicated = {
    #       key    = "dedicated"
    #       value  = "gpuGroup"
    #       effect = "NO_SCHEDULE"
    #     }
    #   }
    #   tags = {
    #     ExtraTag = "example"
    #   }
    # }
  }


  ##################################################################################################################


  #   # Fargate Profile(s)
  #   fargate_profiles = {
  #     default = {
  #       name = "default"
  #       selectors = [
  #         {
  #           namespace = "kube-system"
  #           labels = {
  #             k8s-app = "kube-dns"
  #           }
  #         },
  #         {
  #           namespace = "default"
  #         }
  #       ]

  #       tags = {
  #         Owner = "test"
  #       }

  #       timeouts = {
  #         create = "20m"
  #         delete = "20m"
  #       }
  #     }
  #   }

  #   tags = {
  #     Environment = "dev"
  #     Terraform   = "true"
  #   }
}

###################################securitygroup######################################

resource "aws_security_group_rule" "all_traffice" {
  type              = "ingress"
  description       = "all port"
  from_port         = 0
  to_port           = 65535
  protocol          = "all"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.eks.eks_managed_node_groups.newMNG.security_group_id
}

###################################autoscaling#########################################

resource "aws_autoscaling_attachment" "asg_attachment_bar" {
  autoscaling_group_name = module.eks.eks_managed_node_groups.newMNG.node_group_resources[0].autoscaling_groups[0].name
  alb_target_group_arn   = module.nlb.target_group_arns[0]
}
