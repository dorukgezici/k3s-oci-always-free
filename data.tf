data "oci_identity_availability_domain" "ad" {
  compartment_id = var.oci_tenancy_ocid
  ad_number      = 1
}

resource "random_string" "cluster_token" {
  length           = 48
  special          = true
  numeric          = true
  lower            = true
  upper            = true
  override_special = "^@~*#%/.+:;_"
}
