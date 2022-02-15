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

#######################  RDS  ######################################################################

rds = {
  identifier        = "newpgdb"
  engine            = "postgres"
  engine_version    = "14.1"
  instance_class    = "db.t4g.small"
  allocated_storage = 20
  max_allocated_storage = 1000
  storage_encrypted     = true

  name     = "newpgdb"
  username = "postgres"
  password = "postgres"
  port     = "5432"
 
  iam_database_authentication_enabled = false

  vpc_security_group_ids = "sg-030afe75"

  monitoring_interval = "60"
  monitoring_role_name = "NewRDSMonitoringRole"
  create_monitoring_role = true

  publicly_accessible = false
  multi_az = false

  create_db_subnet_group = true
  db_subnet_group_name = "new-subgroup"
  db_subnet_group_use_name_prefix = false
  db_subnet_group_description = "helloworld"
  # subnet_ids = [aws_subnet.one.id, aws_subnet.second.id]

  family = "postgres14"

  deletion_protection = false

  backup_retention_period = 7
  delete_automated_backups = true

  performance_insights_enabled = true
  performance_insights_kms_key_id = "arn:aws:kms:ap-southeast-1:115595541515:key/44cffea8-6f93-403c-9d53-bce9d9616f1c"
  performance_insights_retention_period = 7 
  
}
