
locals {
  service     = "dashdb"
  name_prefix = var.name_prefix != "" ? var.name_prefix : var.resource_group_name
  label       = "db2-warehouse"
  name        = "${replace(local.name_prefix, "/[^a-zA-Z0-9_\\-\\.]/", "")}-${local.label}"
  credentials = jsondecode(ibm_resource_key.key.credentials_json)

  datacenters = {
    "us-south" = "us-south:washington d.c"
    "au-syd" = "au-syd:Sydney"
    "eu-de" = "eu-de:Frankfurt"
    "eu-gb" = "eu-gb:London"
  }

  datacenter = lookup(local.datacenters, var.resource_location, "us-south:washington d.c")
}

resource null_resource print_names {
  provisioner "local-exec" {
    command = "echo 'Resource group: ${var.resource_group_name}'"
  }
}

data ibm_resource_group resource_group {
  depends_on = [null_resource.print_names]

  name = var.resource_group_name
}

resource ibm_resource_instance instance {
  name              = local.name
  service           = local.service
  plan              = var.plan
  location          = var.resource_location
  resource_group_id = data.ibm_resource_group.resource_group.id
  tags              = var.tags

  parameters = {
    backups             = tostring(var.backup_count)
    datacenter_smp_flex = local.datacenter
    oracle_compatible   = var.oracle_compatible ? "yes" : "no"
  }

  timeouts {
    create = "90m"
    update = "60m"
    delete = "60m"
  }
}

data ibm_resource_instance instance {
  depends_on        = [ibm_resource_instance.instance]

  name              = local.name
  resource_group_id = data.ibm_resource_group.resource_group.id
  location          = var.resource_location
  service           = local.service
}

resource ibm_resource_key key {
  depends_on = [data.ibm_resource_instance.instance]

  name                 = "${local.name}-key"
  role                 = var.role
  resource_instance_id = data.ibm_resource_instance.instance.id

  timeouts {
    create = "15m"
    delete = "15m"
  }
}
