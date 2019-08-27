# OCID of the VCN
vcn_id = "<VCN OCID>"
bastion_subnet = "<Bastion Subnet OCID - Regional"
redis_subnet = "Redis Subnet OCID - Regional"

# Timezone of compute instance
timezone = "GMT"

# Size of volume (in gb) of the instances
compute_boot_volume_size_in_gb = "50"
compute_block_volume_size_in_gb = "200"

# Block Volume mount path
compute_bv_mount_path = "/redis"

# Hostname prefix to define hostname for Redis nodes
Redis_hostname_prefix = "redis"

# Number of Redis nodes to be created
Redis_instance_count = "6"

# Bastion instance shape
bastion_instance_shape = "VM.Standard2.1"

# Redis instance shape
Redis_instance_shape = "VM.Standard2.2"

# OS user
bastion_user = "opc"
compute_instance_user = "opc"






