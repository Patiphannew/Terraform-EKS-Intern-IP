variable "rds" {
  type = map(any)
}



module "db" {
  source  = "terraform-aws-modules/rds/aws"
  version = "~> 3.0"

  identifier = var.rds.identifier

  engine         = var.rds.engine
  engine_version = var.rds.engine_version
  instance_class = var.rds.instance_class

  allocated_storage     = var.rds.allocated_storage
  max_allocated_storage = var.rds.max_allocated_storage
  storage_encrypted     = var.rds.storage_encrypted

  name     = var.rds.name
  username = var.rds.username
  password = var.rds.password
  port     = var.rds.port

  iam_database_authentication_enabled = var.rds.iam_database_authentication_enabled

  vpc_security_group_ids = [var.rds.vpc_security_group_ids]

  #   maintenance_window = "Mon:00:00-Mon:03:00"
  #   backup_window      = "03:00-06:00"

  # Enhanced Monitoring - see example for details on how to create the role
  # by yourself, in case you don't want to create it automatically
  monitoring_interval    = var.rds.monitoring_interval
  monitoring_role_name   = var.rds.monitoring_role_name
  create_monitoring_role = var.rds.create_monitoring_role

  #   tags = {
  #     Owner       = "user"
  #     Environment = "dev"
  #   }

  publicly_accessible = var.rds.publicly_accessible
  multi_az            = var.rds.multi_az

  # DB subnet group from resource "aws_subnet"
  create_db_subnet_group          = var.rds.create_db_subnet_group
  db_subnet_group_name            = var.rds.db_subnet_group_name
  db_subnet_group_use_name_prefix = var.rds.db_subnet_group_use_name_prefix
  db_subnet_group_description     = var.rds.db_subnet_group_description
  subnet_ids                      = [aws_subnet.one.id, aws_subnet.second.id]

  # DB parameter group
  #   family = "mysql5.7"
  #   family = "default.postgres14"
  family = var.rds.family

  # DB option group
  #   major_engine_version = "5.7"

  # Database Deletion Protection
  deletion_protection = var.rds.deletion_protection

  backup_retention_period  = var.rds.backup_retention_period
  delete_automated_backups = var.rds.delete_automated_backups

  performance_insights_enabled          = var.rds.performance_insights_enabled
  performance_insights_kms_key_id       = var.rds.performance_insights_kms_key_id
  performance_insights_retention_period = var.rds.performance_insights_retention_period

  # DB snapshot is created before the DB instance is deleted, If true is specified, no DBSnapshot is created
  skip_final_snapshot = var.rds.skip_final_snapshot
  
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
