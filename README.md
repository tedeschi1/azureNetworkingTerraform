# azureNetworkingTerraform
A collection of customized Azure Networking Terraform modules

**spokeVNET**
The spokeVNET module assumes that a Hub or Core VNET is already in place. The spokeVNET modules contains all the terraform code required to build the spoke vnet, the peerings to the core vnet, the NSG, the spoke vnet subnets, the route table, and update the core vnet route tables with a route to the spoke assuming that the traffic should be routed through a NVA firewall.

The CIDR and Count funtion is used to dynamically create the number of required subnets and assign address space to each of the subnets in the spoke VNET.
  The "subnet-count" varible dictates the number of subnets to be create in the spoke VNET
  The "vnet-address-space" variable is used by the CIDR function to break up the VNET address space and assign networks to the subnets
  

