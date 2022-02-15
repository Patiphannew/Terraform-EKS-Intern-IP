module "db" {
  source  = "terraform-aws-modules/rds/aws"
  version = "~> 3.0"

  identifier = "newpgdb"

  engine         = "postgres"
  engine_version = "14.1"
  instance_class = "db.t4g.small"

  allocated_storage     = 20
  max_allocated_storage = 1000
  storage_encrypted     = true

  name     = "newpgdb"
  username = "postgres"
  password = "postgres"
  port     = "5432"

  iam_database_authentication_enabled = false

  vpc_security_group_ids = ["sg-030afe75"]

  #   maintenance_window = "Mon:00:00-Mon:03:00"
  #   backup_window      = "03:00-06:00"

  # Enhanced Monitoring - see example for details on how to create the role
  # by yourself, in case you don't want to create it automatically
  monitoring_interval    = "60"
  monitoring_role_name   = "NewRDSMonitoringRole"
  create_monitoring_role = true

  #   tags = {
  #     Owner       = "user"
  #     Environment = "dev"
  #   }

  publicly_accessible = false
  multi_az            = false

  # DB subnet group from resource "aws_subnet"
  create_db_subnet_group          = true
  db_subnet_group_name            = "new-subgroup"
  db_subnet_group_use_name_prefix = false
  db_subnet_group_description     = "helloworld"
  subnet_ids                      = [aws_subnet.one.id, aws_subnet.second.id]

  # DB parameter group
  #   family = "mysql5.7"
  #   family = "default.postgres14"
  family = "postgres14"

  # DB option group
  #   major_engine_version = "5.7"

  # Database Deletion Protection
  deletion_protection = false

  backup_retention_period  = 7
  delete_automated_backups = true

  performance_insights_enabled          = true
  performance_insights_kms_key_id       = "arn:aws:kms:ap-southeast-1:115595541515:key/44cffea8-6f93-403c-9d53-bce9d9616f1c"
  performance_insights_retention_period = 7

  #   parameters = [
  #     {
  #       name = "character_set_client"
  #       value = "utf8mb4"
  #     },
  #     {
  #       name = "character_set_server"
  #       value = "utf8mb4"
  #     }
  #   ]

  #   options = [
  #     {
  #       option_name = "MARIADB_AUDIT_PLUGIN"

  #       option_settings = [
  #         {
  #           name  = "SERVER_AUDIT_EVENTS"
  #           value = "CONNECT"
  #         },
  #         {
  #           name  = "SERVER_AUDIT_FILE_ROTATIONS"
  #           value = "37"
  #         },
  #       ]
  #     },
  #   ]
}
