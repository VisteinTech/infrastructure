output "public-subnet-id" {
  value = module.public-subnet.public-subnet-info.id
}

output "public-ip" {
  value = module.public-server.public-server-info.public_ip
}

output "private-subnet-id" {
  value = module.private-subnet.private-subnet-info.id
}




/*
output "private-server-id" {
  value = module.private-server.private-server-info.ami
}
*/