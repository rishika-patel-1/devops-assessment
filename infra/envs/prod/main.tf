module "network" {
  source = "../../modules/network"

  environment = var.environment

  vpc_cidr = var.vpc_cidr

  public_subnet_1_cidr  = var.public_subnet_1_cidr
  public_subnet_2_cidr  = var.public_subnet_2_cidr
  private_subnet_1_cidr = var.private_subnet_1_cidr
  private_subnet_2_cidr = var.private_subnet_2_cidr

  availability_zone_1 = var.availability_zone_1
  availability_zone_2 = var.availability_zone_2
}

module "security" {
  source = "../../modules/security"

  environment = var.environment
  vpc_id      = module.network.vpc_id
}

module "alb" {
  source = "../../modules/alb"

  environment = var.environment
  vpc_id      = module.network.vpc_id

  public_subnet_ids = [
    module.network.public_subnet_1_id,
    module.network.public_subnet_2_id
  ]

  alb_security_group_id = module.security.alb_security_group_id
}

module "ecs" {
  source = "../../modules/ecs"

  environment = var.environment
  vpc_id      = module.network.vpc_id

  private_subnet_ids = [
    module.network.private_subnet_1_id,
    module.network.private_subnet_2_id
  ]

  ecs_security_group_id = module.security.ecs_security_group_id

  # NEW
  target_group_arn = module.alb.target_group_arn
}

module "rds" {
  source = "../../modules/rds"

  environment = var.environment

  private_subnet_ids = [
    module.network.private_subnet_1_id,
    module.network.private_subnet_2_id
  ]

  rds_security_group_id = module.security.rds_security_group_id

  db_name           = "appdb"
  db_username       = "postgres"
  db_password       = "Password@12345"
  db_instance_class = "db.t3.micro"
}