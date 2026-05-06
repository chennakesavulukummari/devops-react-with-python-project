# C3OPS Application Infrastructure - Preprod Environment
aws_region  = "ap-south-2"
app_name    = "cloudcostconsole"
environment = "preprod"

# VPC and Subnet Configuration (from core-infra)
# These values will be passed from the preprod main.tf module call

# EC2 Configuration
instance_type        = "t3.micro"
asg_desired_capacity = 1
asg_min_size         = 1
asg_max_size         = 3

# Database Configuration
enable_database      = false
db_engine            = "mysql"
db_instance_class    = "db.t3.micro"
db_allocated_storage = 20
db_username          = "admin"
# db_password - Set via environment variable or Terraform variables (sensitive data)

# HTTPS Configuration
enable_https = false
# certificate_arn - Set when HTTPS is enabled

# Tags
tags = {
  Project      = "cloudcostconsole"
  Environment  = "preprod"
  Application  = "Website"
  CostCenter   = "FinOps"
  Owner        = "DevOps"
  BackupPolicy = "Daily"
  ManagedBy    = "terraform"
}
