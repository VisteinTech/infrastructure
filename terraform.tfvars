vpc_cidr_block = "192.168.0.0/16"
cidr_blocks = [
  { cidr_block = "192.168.16.0/20", name = "subnet-1" },
  { cidr_block = "192.168.80.0/20", name = "subnet-2" }
]
env_prefix = "dev"
avail_zone = "us-east-2a"
region     = "us-east-2"

