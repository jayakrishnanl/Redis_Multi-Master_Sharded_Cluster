# Get list of Availability Domains
data "oci_identity_availability_domains" "ADs" {
  compartment_id = "${var.tenancy_ocid}"
}

# Get list of Fault Domains
data "oci_identity_fault_domains" "fds" {
  availability_domain = "${element(local.ADs, 0)}"
  compartment_id      = "${var.compartment_ocid}"
}

resource "random_string" "redis_password" {
  length  = 64
  special = false
}

data "template_file" "bootstrap_Redis" {
  template = "${file("${path.module}/userdata/bootstrap_Redis.tpl")}"

  vars = {
    timezone = "${var.timezone}"
  }
}
