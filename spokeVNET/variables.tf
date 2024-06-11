variable "sp-client-id" {
    description = "Service Principal Client ID"
}

variable "spokevnet-subscription-id" {
    description = "Subscription ID of the Spoke VNET to be Created"
    type = string
}

variable "sp-client-secret" {
    description = "Service Principal Client Secret"
}

variable "tenant-id" {
    description = "Tenant ID of the New VNET"
}

variable "nameofresourcegroup" {
    description = "Name of VNET RG"
    type = string
}

variable "nameofvnet" {
    description = "Name of VNET to Be Created"
    type = string
}

variable "nameofcorevnet" {
    description = "Name of the existing Core VNET"
    type = string
}

variable "nameofcorevnet-resourcegroup" {
    description = "Name of the existing Core VNET Resource Group"
    type = string
}

variable "regionofresourcegroup" {
    description = "Region of Resource Group"
}

variable "subnet-count" {
    description = "number of subnets"
    type = number
    default = 5
}

variable "vnet-address-space" {
    description = "Address Space Assigned to the New VNET"
    type = string
}

variable "tags-app-id" {
    description = "App ID Tag"
    type = string
}

variable "tags-app-name" {
    description = "App Name Tag"
    type = string
}

variable "tags-business-service" {
    description = "Business Service Tag"
    type = string
}

variable "tags-charge-code" {
    description = "Charge Code Tag"
    type = string
}

#https://buildvirtual.net/terraform-count-examples/
variable "subnet-name-pfx" {
  description = "Subnet Names"
  default     = "test-subnetname-"
  type        = string
}
