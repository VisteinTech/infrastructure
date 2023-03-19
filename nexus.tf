module "nexus" {
  source = "./modules/public_server"
  
  name = "nexus"
  ami = "ami-05a36e1502605b4aa"
  vpc_id = module.ci-vpc.vpc-info.id
  subnet_id = module.subnet-public.subnet-id
  public_key_path = var.public_key_path
  sg-ids = module.nexus-sg.security-info.id
  instance_type = var.instance_type
  avail_zone = var.avail_zone[0]
  env_prefix = var.env_prefix[0]
  key_name = module.key_name.public-key-name
  user_data = "./bootstrap_scripts/nexus.sh"
}

module "nexus-sg" {
  source = "./modules/security_group"

  sg-name = "nexus-sg"
  vpc_id = module.ci-vpc.vpc-info.id
  ingress_ports = [22,8081]
  env_prefix = var.env_prefix[0]
}