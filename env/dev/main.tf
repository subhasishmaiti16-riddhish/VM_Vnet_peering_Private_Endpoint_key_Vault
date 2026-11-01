module "dev-rg" {
  source = "../../child/rg"
  rg     = var.dev-rg
}

module "dev-vnet" {
  depends_on = [module.dev-rg]
  source     = "../../child/vnet"
  vnet       = var.dev-vnet
}

module "dev-subnet" {
  depends_on = [module.dev-vnet]
  source     = "../../child/subnet"
  subnet     = var.dev-subnet
}

module "dev-pip" {
  depends_on = [module.dev-rg]
  source     = "../../child/pip"
  pip        = var.dev-pip
}

module "dev-bastion" {
  depends_on = [module.dev-pip, module.dev-subnet, module.dev-rg]
  source     = "../../child/bastion"
  bastion    = var.dev-bastion
}


module "dev-vm" {
  depends_on = [module.dev-subnet]
  source     = "../../child/vm"
  vm         = var.dev-vm
}
module "dev-storage" {
  depends_on = [module.dev-rg]
  source     = "../../child/storage"
  storage    = var.dev-storage
}
module "dev-peering" {
  depends_on = [module.dev-vnet]
  source     = "../../child/peering"
  peering    = var.dev-peering
}
module "dev-endpoint" {
  depends_on = [module.dev-vnet]
  source     = "../../child/private_endpoint"
  endpoint   = var.dev-endpoint
}
