region            = "us-east-2"
vpc_cidr_block    = ["10.0.0.0/16", "10.100.0.0/16"]
subnet_cidr_block = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
avail_zone        = ["us-east-2a", "us-east-2b", "us-east-2c"]
env_prefix        = ["dev", "test", "prod"]
instance_type     = "t2.micro"
