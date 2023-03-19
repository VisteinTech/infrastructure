output "public-key-name" {
value = aws_key_pair.public-server-key.key_name
}

output "public-key-id" {
value = aws_key_pair.public-server-key.key_pair_id
}
