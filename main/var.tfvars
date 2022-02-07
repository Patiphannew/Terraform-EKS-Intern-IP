#######################eks########################################################

eks = {
  cluster_name                    = "new-cluster-2"
  cluster_version                 = "1.21"
  cluster_endpoint_private_access = true
  cluster_endpoint_public_access  = true
  vpc_id                          = "vpc-b8d13ade"
}
eksSubnet = ["subnet-6221ed2a", "subnet-7e65ee27", "subnet-977ea2f1"]


eksManagedNodeGroupDefaults = {
  ami_type               = "AL2_x86_64"
  disk_size              = 20
  instance_types         = "t3.medium"
  vpc_security_group_ids = "sg-030afe75"
}
eksManagedNodeGroup = {
  name           = "newMNG"
  desired_size   = 1
  max_size       = 2
  min_size       = 1
  instance_types = "t3.medium"
  capacity_type  = "ON_DEMAND"
}

# eksManagedNodeGroupGGEZ = "banjo_managednode3"



#######################nlb#######################################################

myNlb = {
  nlbName = "newnlb"
  lbType  = "network"
  vpc_id  = "vpc-b8d13ade"
}
nlbSubnet = ["subnet-6221ed2a", "subnet-7e65ee27", "subnet-977ea2f1"]

targetGroups = {
  namePrefix      = "NEWGG"
  backendProtocol = "TCP"
  backendPort     = 32593
  targetType      = "instance"
}

httpTcpListeners = {
  port             = 80
  protocol         = "TCP"
  targetGroupIndex = 0
}
