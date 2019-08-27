variable "tenancy_ocid" {}
variable "user_ocid" {}
variable "fingerprint" {}
variable "private_key_path" {}

variable "region" {
  default = "eu-frankfurt-1"
}

variable "compartment_ocid" {}

variable "vcn_id" {
  description = "OCID your VCN - Make sure you have tagged the Private & Public Subnets per instructions"
}
/*
variable "bastion_nsg" {
  description = "NSG of Bastion Subnet"
}

variable "redis_nsg" {
  description = "NSG of ELK Subnet"
}
*/
variable "bastion_subnet" {
  description = "OCID of Bastion Subnet - Regional"
  default     = ""
}

variable "redis_subnet" {
  description = "OCID of Redis Subnet - Regional"
  default     = ""
}

variable "redis_port" {
  description = "Redis Port"
  default     = "6379"
}

variable "RegionalPrivateKey" {
  description = "Freeform tag Key specified to your existing Regional Private Subnet"
}

variable "RegionalPrivateValue" {
  description = "Freeform tag Value specified to your existing Regional Private Subnet"
}

variable "RegionalPublicKey" {
  description = "Freeform tag Key specified to your existing Regional Public Subnet"
}

variable "RegionalPublicValue" {
  description = "Freeform tag Value specified to your existing Regional Public Subnet"
}

variable "AD" {
  description = "Setting AD = [\"1\"] deploys infrastructure in single availability domain (Availability domain 1 of the tenancy in this case) and AD = [\"1\",\"2\"] deploys infrastructure in multiple ADs (Availability domains 1 and 2 of the tenancy in this case)"
  type        = "list"
}

# Compute Instance variables
variable "ssh_public_key" {
  description = "SSH public key for instances"
}

variable "ssh_private_key" {
  description = "SSH private key for instances"
}

variable "compute_boot_volume_size_in_gb" {
  description = "Boot volume size of LB nodes"
}

variable "compute_block_volume_size_in_gb" {
  description = "Block volume size in gb"
}

variable "compute_bv_mount_path" {
  description = "Block Volume mount path"
}

variable "Redis_instance_count" {
  description = "Number of Redis nodes"
}

variable "Redis_hostname_prefix" {
  description = "Hostname profix for Redis Nodes"
}

variable "Redis_instance_shape" {
  description = "Redis Instance shape"
}

variable "bastion_instance_shape" {
  description = "Bastion node shape"
}

variable "bastion_user" {
  description = "Bastion OS user"
}

variable "compute_instance_user" {
  description = "Compute node OS user"
}

variable "instance_image_ocid" {
  type = "map"

  default = {
    // See https://docs.us-phoenix-1.oraclecloud.com/images/
    // Oracle-provided image "Oracle-Linux-7.6-2019.06.15-0"
    ap-seoul-1 = "ocid1.image.oc1.ap-seoul-1.aaaaaaaa6jrkptivowaai45lsbrk7ox3kdveyylzdcfttnjzlg5i4idlg6ta"

    ap-tokyo-1     = "ocid1.image.oc1.ap-tokyo-1.aaaaaaaad4gozsm4dexrtoazw7esigotehv5uhbq4plmqrfrz2gxhag6lgja"
    ca-toronto-1   = "ocid1.image.oc1.ca-toronto-1.aaaaaaaafdgjpavzr7iwzj4avsk7hzov3jwheu6k3sltlarac6mg6bhopkbq"
    us-phoenix-1   = "ocid1.image.oc1.phx.aaaaaaaa5b5tbfa4qkmu5fkm2m4aaluaqu73f32peylcjhs3vaglu6e223yq"
    us-ashburn-1   = "ocid1.image.oc1.iad.aaaaaaaay66pu7z27ltbx2uuatzgfywzixbp34wx7xoze52pk33psz47vlfa"
    eu-frankfurt-1 = "ocid1.image.oc1.eu-frankfurt-1.aaaaaaaazfzlw2infpo3svzjgrcl237xsbod4l5yuzfpqdqmmawia2womz5q"
    uk-london-1    = "ocid1.image.oc1.uk-london-1.aaaaaaaaahbkgd2yhw7yg6io76mbuwwtuk4monzpsr3r7nuiegttu5q75r6q"
  }
}

variable "timezone" {
  description = "Set timezone for servers"
}
