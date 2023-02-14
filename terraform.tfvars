vpc_cidr_block       = "10.100.0.0/16"
region               = "us-east-2"
env_prefix           = "dev"
subnet_cidr_block    = "10.100.0.0/24"
avail_zone           = "us-east-2a"
public_key_path      = "~/.ssh/id_rsa.pub"
master_instance_type = "t2.medium"
worker_instance_type = "t2.medium"
ami_image            = "ami-0ab0629dba5ae551d"
private_key_location = "~/.ssh/id_rsa"