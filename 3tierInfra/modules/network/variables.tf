variable "resource_group_name" {
  description = "Resouce group name where vnet will be created"
}

variable "location" {
  description = "Location where resoutrce will be created"
}

variable "virutal_network_name" {
  description = "Name of the vnet to be created"
}

variable "vnet_address_space" {
    description = "Vnet address space, e.g. 10.0.0.0/16"
}

variable "subnet_names" {
  description = "Subnets names, e.g. ['sub1', 'sub2']"
  type        = list(string)
}

variable "subnet_address_prefixes" {
  description = "Subnet address prefixes, e.g.  [10.0.1.0/24]"
  type        = list(string)
}

variable "tags" {
  description = "Tags to be added to the vnet"
  type        = map(string)
}


variable "nsg_ids" {
  description = "A map of subnet name to Network Security Group IDs"
  type        = map(string)

  default = {
  }
}