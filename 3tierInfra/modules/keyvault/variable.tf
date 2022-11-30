variable "resource_group_name" {
  description = "Resouce group name where KV will be created"
}

variable "location" {
  description = "Location where resoutrce will be created"
}

variable "kv_name" {
    description = "Name of the key vault"
}


variable "tags" {
  description = "Tags to be added to the KV"
  type        = map(string)
}