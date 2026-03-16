variable "availability_domain" {
  type    = string
  default = "SXtm:EU-FRANKFURT-1-AD-1"
}

provider "oci" {
  auth                = "ApiKey"
  config_file_profile = "DEFAULT"
}

resource "oci_core_instance" "generated_oci_core_instance" {
  agent_config {
    is_management_disabled = "false"
    is_monitoring_disabled = "false"
    plugins_config {
      desired_state = "DISABLED"
      name          = "Vulnerability Scanning"
    }
    plugins_config {
      desired_state = "DISABLED"
      name          = "Management Agent"
    }
    plugins_config {
      desired_state = "ENABLED"
      name          = "Custom Logs Monitoring"
    }
    plugins_config {
      desired_state = "DISABLED"
      name          = "Compute RDMA GPU Monitoring"
    }
    plugins_config {
      desired_state = "ENABLED"
      name          = "Compute Instance Monitoring"
    }
    plugins_config {
      desired_state = "DISABLED"
      name          = "Compute HPC RDMA Auto-Configuration"
    }
    plugins_config {
      desired_state = "DISABLED"
      name          = "Compute HPC RDMA Authentication"
    }
    plugins_config {
      desired_state = "ENABLED"
      name          = "Cloud Guard Workload Protection"
    }
    plugins_config {
      desired_state = "DISABLED"
      name          = "Block Volume Management"
    }
    plugins_config {
      desired_state = "DISABLED"
      name          = "Bastion"
    }
  }

  availability_config {
    recovery_action = "RESTORE_INSTANCE"
  }

  availability_domain = var.availability_domain   # ← now dynamic

  compartment_id = "ocid1.tenancy.oc1..aaaaaaaa6k2h22qk2szk6h2eg6hebjgiqedobsxewm55zpygms3jrqsn2jva"

  create_vnic_details {
    assign_ipv6ip             = "false"
    assign_private_dns_record = "true"
    assign_public_ip          = "false"
    subnet_id                 = "${oci_core_subnet.generated_oci_core_subnet.id}"
  }

  display_name = "instance-20260315-2228"

  instance_options {
    are_legacy_imds_endpoints_disabled = "false"
  }

  is_pv_encryption_in_transit_enabled = "true"

  metadata = {
    "ssh_authorized_keys" = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCa8RLnzsD460hCuZ6u77ybwW6Jzgh1JaA5eI7g79u4rf3SRK5U1F+ErRGUuO5NjD+ZxqsQsQ6HluSo/deFoi7MiYddcw7K+K9zKKX7eCNv43/z2ZdfyfeNpDPbRIJ589ryQHaNqbnnPDc286mu/OKZoPMt+BJJUSe3kgFe7pNTke6Xcj0uXxIJ07g2IRm2b/pvtIHZsBHWxrb6dUf9GDGPIPVycS3xWJ++xggCSFgb4qGzqRnur1oeoW+XL4kT7ecSf6T5cNmbhRPcvdVrqox8ozwp2PmXmUY4QUwphf/F2nzqKDe7vbCRH/+XQlsj+sQCTe8P5ZgZMdmKR4clamwL ssh-key-2026-03-15"
  }

  shape = "VM.Standard.A1.Flex"
  shape_config {
    memory_in_gbs = "24"
    ocpus         = "4"
  }

  source_details {
    source_id   = "ocid1.image.oc1.eu-frankfurt-1.aaaaaaaasoblespfnzqa67jnq4psbpnbal4mlh2tpwnlhnhvmkhzuqbrxu4a"
    source_type = "image"
  }
}

resource "oci_core_vcn" "generated_oci_core_vcn" {
  cidr_block     = "10.0.0.0/16"
  compartment_id = "ocid1.tenancy.oc1..aaaaaaaa6k2h22qk2szk6h2eg6hebjgiqedobsxewm55zpygms3jrqsn2jva"
  display_name   = "vcn-20260315-2229"
  dns_label      = "vcn03152229"
}

resource "oci_core_subnet" "generated_oci_core_subnet" {
  cidr_block        = "10.0.0.0/24"
  compartment_id    = "ocid1.tenancy.oc1..aaaaaaaa6k2h22qk2szk6h2eg6hebjgiqedobsxewm55zpygms3jrqsn2jva"
  display_name      = "subnet-20260315-2229"
  dns_label         = "subnet03152229"
  route_table_id    = "${oci_core_vcn.generated_oci_core_vcn.default_route_table_id}"
  vcn_id            = "${oci_core_vcn.generated_oci_core_vcn.id}"
}

resource "oci_core_internet_gateway" "generated_oci_core_internet_gateway" {
  compartment_id = "ocid1.tenancy.oc1..aaaaaaaa6k2h22qk2szk6h2eg6hebjgiqedobsxewm55zpygms3jrqsn2jva"
  display_name   = "Internet Gateway vcn-20260315-2229"
  enabled        = "true"
  vcn_id         = "${oci_core_vcn.generated_oci_core_vcn.id}"
}

resource "oci_core_default_route_table" "generated_oci_core_default_route_table" {
  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = "${oci_core_internet_gateway.generated_oci_core_internet_gateway.id}"
  }
  manage_default_resource_id = "${oci_core_vcn.generated_oci_core_vcn.default_route_table_id}"
}