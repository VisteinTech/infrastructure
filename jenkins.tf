module "jenkins" {
  source = "./modules/public_server"
  
  name = "jenkins"
  ami = "ami-0d5bf08bc8017c83b" #ubuntu ami
  vpc_id = module.ci-vpc.vpc-info.id
  subnet_id = module.subnet-public.subnet-id
  public_key_path = var.public_key_path
  sg-ids = module.jenkins-sg.security-info.id
  instance_type = var.instance_type
  avail_zone = var.avail_zone[0]
  env_prefix = var.env_prefix[0]
  key_name = module.key_name.public-key-name
  user_data = "./bootstrap_scripts/jenkins.sh"
}

module "jenkins-sg" {
  source = "./modules/security_group"

  sg-name = "jenkins-sg"
  vpc_id = module.ci-vpc.vpc-info.id
  ingress_ports = [22,8080,9000,8081, 80]

  env_prefix = var.env_prefix[0]
}