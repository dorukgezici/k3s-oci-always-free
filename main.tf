terraform {
  required_version = ">= 1.8.2"
  required_providers {
    oci = {
      source  = "oracle/oci"
      version = ">= 5.39.0"
    }
  }
}
