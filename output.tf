output "BastionPublicIPs" {
  value = "${module.create_bastion.ComputePublicIPs}"
}

output "RedisPrivateIPs" {
  value = "${module.create_redis.ComputePrivateIPs}"
}

output "RedisPassword" {
  value     = "${random_string.redis_password.result}"
  sensitive = false
}