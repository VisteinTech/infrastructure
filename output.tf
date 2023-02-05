# output "ubuntu-ami" {
#   value = data.aws_ami.ubuntu.image_id
# }

output "master-node-ip" {
  value = aws_instance.cluster-master-node.public_ip
}

output "worker-node-ip" {
  value = aws_instance.cluster-worker-node.public_ip
}