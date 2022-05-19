module "db2_warehouse" {
  source = "./module"

  resource_group_name = module.resource_group.name
  resource_location   = "us-south"
  tags                = []
}

resource local_file db2wh_out {
  content = jsonencode({
    id = module.db2_warehouse.id
    crn = module.db2_warehouse.crn
    name = module.db2_warehouse.name
    location = module.db2_warehouse.location
    service = module.db2_warehouse.service
    label = module.db2_warehouse.label
    type = module.db2_warehouse.type
    host = module.db2_warehouse.host
    port = module.db2_warehouse.port
    database_name = module.db2_warehouse.database_name
    username = module.db2_warehouse.username
    password = module.db2_warehouse.password
  })
  filename = "${path.cwd}/.db2wh_out"
}
