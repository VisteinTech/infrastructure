module "sonarqube" {
  source = "./modules/public_server"
  
  name = "sonar"
  ami = "ami-05a36e1502605b4aa"
  vpc_id = module.ci-vpc.vpc-info.id
  subnet_id = module.subnet-public.subnet-id
  public_key_path = var.public_key_path
  sg-ids = module.sonar-sg.security-info.id
  instance_type = var.instance_type
  avail_zone = var.avail_zone[0]
  env_prefix = var.env_prefix[0]
  key_name = module.key_name.public-key-name
  user_data = "./bootstrap_scripts/sonarServer.sh"
}


module "sonar-sg" {
  source = "./modules/security_group"

  sg-name = "sonar-sg"
  vpc_id = module.ci-vpc.vpc-info.id
  ingress_ports = [22,9000]
  env_prefix = var.env_prefix[0]
}
