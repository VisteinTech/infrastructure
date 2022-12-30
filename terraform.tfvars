vpc_cidr_block = "10.0.0.0/16"
subnet_cidr_blocks = [
    {cidr_block = "10.0.0.0/18", name = "subnet-1"},
    {cidr_block = "10.0.64.0/18", name = "subnet-2"},
    {cidr_block = "10.0.128.0/18", name = "subnet-3"}  
    ]
env_prefix = "dev"
avail_zone = "us-east-2a"

