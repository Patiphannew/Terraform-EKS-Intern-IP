module "eks" {
  source = "terraform-aws-modules/eks/aws"

  cluster_name                    = "my-cluster"
  cluster_version                 = "1.21"
  cluster_endpoint_private_access = true
  cluster_endpoint_public_access  = true

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

  vpc_id     = "vpc-b8d13ade"
  subnet_ids = ["subnet-6221ed2a", "subnet-7e65ee27", "subnet-977ea2f1"]

  ##################################################################################################################




  # Self Managed Node Group(s)
  # self_managed_node_group_defaults = {
  #   instance_type                          = "t3.medium"
  #   update_launch_template_default_version = true
  #   iam_role_additional_policies           = ["arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"]
  # }

  # self_managed_node_groups = {
  #   one = {
  #     name = "my-smng"

  #     public_ip    = true
  #     max_size     = 1
  #     desired_size = 1

  #     use_mixed_instances_policy = true
  #     mixed_instances_policy = {
  #       instances_distribution = {
  #         on_demand_base_capacity                  = 0
  #         on_demand_percentage_above_base_capacity = 10
  #         spot_allocation_strategy                 = "capacity-optimized"
  #       }

  # override = [
  #   {
  #     instance_type     = "t3.medium"
  #     weighted_capacity = "1"
  #   },
  #   {
  #     instance_type     = "t3.medium"
  #     weighted_capacity = "2"
  #   },
  # ]
  # }

  #       pre_bootstrap_user_data = <<-EOT
  #       echo "foo"
  #       export FOO=bar
  #       EOT

  #       bootstrap_extra_args = "--kubelet-extra-args '--node-labels=node.kubernetes.io/lifecycle=spot'"

  #       post_bootstrap_user_data = <<-EOT
  #       cd /tmp
  #       sudo yum install -y https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm
  #       sudo systemctl enable amazon-ssm-agent
  #       sudo systemctl start amazon-ssm-agent
  #       EOT
  #     }
  # }


  ##################################################################################################################



  # EKS Managed Node Group(s)
  eks_managed_node_group_defaults = {
    ami_type       = "AL2_x86_64"
    disk_size      = 20
    instance_types = ["t3.medium"]
    # vpc_security_group_ids = [aws_security_group.additional.id]
    vpc_security_group_ids = ["sg-030afe75"]
  }

  eks_managed_node_groups = {
    # name = "new-NG"
    # blue = {}
    new-NG = {
      min_size     = 1
      max_size     = 1
      desired_size = 1

      instance_types = ["t3.medium"]
      # capacity_type  = "SPOT"
      capacity_type = "ON_DEMAND"
    }

    # green = {
    #   name = "new-NG"
    #   min_size     = 1
    #   max_size     = 1
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
