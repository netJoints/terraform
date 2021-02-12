# Build Basic GCP Transit using Terraform Modules

### Summary

This standard POC builds Aviatrix Transit and 2 spokes in GCP. Refer to the bill of materials below for additional detail.
The test VMs will use ```~/.ssh/id_rsa.pub``` for ssh authentication, have GCP firewall rules with port 22 open and be provided public IPs.
In order to get the public IPs for the VMs you'll need to go to the GCP Console build instructions and requirements are [here](/test-vms/simple).

### BOM

- 1 Aviatrix Transit in GCP with 2 spokes
- 1 Custom Resource group with 2 Ubuntu 18.04 VMs with iperf3 installed **(1 per spoke)**

### Infrastructure diagram

<img src="img/belmont.png">

### Software Version Requirements

Component | Version
--- | ---
Aviatrix Controller | (6.2) UserConnect-6.2.1837 (Nov 10 Patch)
Aviatrix Terraform Provider | 2.17
Terraform | 0.12

### Modules

Module Name | Version | Description
:--- | :--- | :---
[terraform-aviatrix-modules/gcp-transit/aviatrix](https://registry.terraform.io/modules/terraform-aviatrix-modules/gcp-transit/aviatrix/latest) | 2.0.0 | This module deploys a VPC and an Aviatrix transit gateway in GCP with HA
[terraform-aviatrix-modules/gcp-spoke/aviatrix](https://registry.terraform.io/modules/terraform-aviatrix-modules/gcp-spoke/aviatrix/latest) | 2.0.1 | This module deploys a VPC and an Aviatrix spoke gateway in GCP and attaches it to an Aviatrix Transit Gateway


### Variables

The variables are defined in ```terraform.tfvars```

**Note:** ```ha_enabled = false``` controls whether ha is built for spokes. 

### Prerequisites

- Software version requirements met
- Aviatrix Controller with Access Accounts defined for GCP
- Sufficient limits in place for each region in scope (EIPs, Compute quotas, etc.)
- terraform .12 in the user environment ```terraform -v```

### Workflow

- Do not run this with TF Cloud local files are expected ```~/.ssh/id_rsa.pub```
- Modify ```terraform.auto.tfvars.template``` _(i.e. access accounts, regions, cidrs, etc.)_ and save the file as ```terraform.auto.tfvars```
- ```terraform init```
- ```terraform plan```
- ```terraform apply --auto-approve```



