output "public-subnet-id" {
  value = module.public-subnet.public-subnet-info.id
}

output "public-ip" {
  value = module.public-server.public-server-info.public_ip
}

output "public-ip2" {
  value = module.public-server2.public-server-info.public_ip
}

output "private-subnet-id" {
  value = module.private-subnet.private-subnet-info.id
}

/*
# output "private-ip-1" {
#   value = module.private-server.private-server-info.private_ip
# }
*/



/*
output "private-server-id" {
  value = module.private-server.private-server-info.ami
}
*/