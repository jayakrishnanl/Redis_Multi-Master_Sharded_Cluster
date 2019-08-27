resource "null_resource" "provision_Redis" {
  count = "${var.Redis_instance_count}"

  connection {
    agent               = false
    timeout             = "30m"
    host                = "${element(module.create_redis.ComputePrivateIPs, count.index)}"
    user                = "${var.compute_instance_user}"
    private_key         = "${var.ssh_private_key}"
    bastion_host        = "${module.create_bastion.ComputePublicIPs[0]}"
    bastion_user        = "${var.bastion_user}"
    bastion_private_key = "${var.ssh_private_key}"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum -y install http://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm",
      "sudo yum -y install http://rpms.remirepo.net/enterprise/remi-release-7.rpm",
      "sudo yum -y install --enablerepo=remi redis",
      "sudo firewall-offline-cmd  --zone=public --add-port=6379/tcp",
      "sudo firewall-offline-cmd  --zone=public --add-port=16379/tcp",
      "sudo systemctl restart firewalld",
      "sudo cp /etc/redis.conf /etc/redis.conf.orig",
      "sudo sh -c \"sed -i 's/^bind 127.0.0.1/# bind 127.0.0.1/g' /etc/redis.conf\"",
      "sudo sh -c \"sed -i 's/^# cluster-enabled yes/cluster-enabled yes/g' /etc/redis.conf\"",
      "sudo sh -c \"sed -i 's/^# cluster-config-file /cluster-config-file /g' /etc/redis.conf\"",
      "sudo sh -c \"sed -i 's/^# cluster-node-timeout 15000/cluster-node-timeout 15000/g' /etc/redis.conf\"",
      "sudo sh -c \"sed -i 's/^daemonize no/daemonize yes/g' /etc/redis.conf\"",
      "sudo sh -c \"sed -i 's/^repl-diskless-sync no/repl-diskless-sync yes/g' /etc/redis.conf\"",
      "sudo sh -c \"sed -i 's/^# repl-backlog-size 1mb/repl-backlog-size 512mb/g' /etc/redis.conf\"",
      "sudo sh -c \"sed -i 's/^# requirepass foobared/requirepass ${random_string.redis_password.result}/g' /etc/redis.conf\"",
      "sudo systemctl start redis.service",
    ]
  }
}

resource "null_resource" "redis_join_cluster" {
  depends_on = ["null_resource.provision_Redis"]
  connection {
    agent               = false
    timeout             = "30m"
    host                = "${element(module.create_redis.ComputePrivateIPs, 0)}"
    user                = "${var.compute_instance_user}"
    private_key         = "${var.ssh_private_key}"
    bastion_host        = "${module.create_bastion.ComputePublicIPs[0]}"
    bastion_user        = "${var.bastion_user}"
    bastion_private_key = "${var.ssh_private_key}"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo sh -c \"echo \"yes\" | redis-cli --cluster create ${join(" ", formatlist("%s:${var.redis_port}", "${module.create_redis.ComputePrivateIPs}"))} --cluster-replicas 1 -a ${random_string.redis_password.result}\"",
    ]
  }
}

