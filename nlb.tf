module "nlb" {
  source  = "terraform-aws-modules/alb/aws"
  # source  = "./.terraform/modules/nlb"
  version = "~> 6.0"

  name = "test-nlb"             # Create load balancer name

  load_balancer_type = "network"    # Create load balancer type

  vpc_id  = "vpc-b8d13ade"
  subnets = ["subnet-6221ed2a", "subnet-7e65ee27", "subnet-977ea2f1"]


  target_groups = [                 # Create target groups
    {
      name_prefix      = "test-TG"
      backend_protocol = "TCP"
      backend_port     = 32593
      # target_type      = "ip"
      target_type      = "instance"
    }
  ]

#   https_listeners = [
#     {
#       port               = 443
#       protocol           = "TLS"
#       certificate_arn    = "arn:aws:iam::123456789012:server-certificate/test_cert-123456789012"
#       target_group_index = 0
#     }
#   ]

  http_tcp_listeners = [           # Create listeners
    {
      port               = 80
      protocol           = "TCP"
      target_group_index = 0
    }
  ]

#   tags = {
#     Environment = "Test"
#   }
}