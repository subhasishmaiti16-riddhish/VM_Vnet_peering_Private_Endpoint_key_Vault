module "prod-rg" {
  source = "../../child/rg"
  rg     = var.prod-rg
}

module "prod-vnet" {
  depends_on = [module.dev-rg]
  source     = "../../child/vnet"
  vnet       = var.prod-vnet
}

module "prod-subnet" {
  depends_on = [module.prod-vnet]
  source     = "../../child/subnet"
  subnet     = var.prod-subnet
}

module "prod-pip" {
  depends_on = [module.prod-rg]
  source     = "../../child/pip"
  pip        = var.prod-pip
}

module "prod-bastion" {
  depends_on = [module.prod-pip, module.prod-subnet, module.prod-rg]
  source     = "../../child/bastion"
  bastion    = var.prod-bastion
}


module "prod-vm" {
  depends_on = [module.prod-subnet]
  source     = "../../child/vm"
  vm         = var.prod-vm
}
module "prod-storage" {
  depends_on = [module.prod-rg]
  source     = "../../child/storage"
  storage    = var.prod-storage
}
module "prod-peering" {
  depends_on = [module.prod-vnet]
  source     = "../../child/peering"
  peering    = var.prod-peering
}
module "prod-endpoint" {
  depends_on = [module.prod-vnet]
  source     = "../../child/private_endpoint"
  endpoint   = var.prod-endpoint
}
