# workdev-alst-PLM 

## Create user managed identity in azure

it is recommended to use user managed identity for the deployment of the solution.

### basic tab

1. Navigate to the Azure portal.
2. From home click “Create a resource”.
3. Search for “Managed Identity”.
4. Select “User Assigned Managed Identity”.
5. and click “Create”.
6. Select the subscription and resource group.
7. Select the region.
8. chose a name for the identity.
9. Click "Next : Tags".

### Tags tab

1. Enter any required tags and click "Next : Review + create".
2. Click "Create".

## Assign the user managed identity to the resource group hosting the PLM VMs and Log Analytics workspace

### role tab

1. Navigate to the Azure portal.
1. Select "resource groups" from the left menu.
1. Select the resource group hosting the PLM VMs and Log Analytics workspace.
1. select "Access control (IAM)" from the left menu.
1. Click "Add" and select "Add role assignment".
1. in the search box type "log Analytics" and select "Log Analytics Contributor".
1. click "Next".

### Members tab

1. Assign access to, select "Managed Identity".
1. click "Select members".
1. Managed identity drop down, select the user managed identity.
1. Select the managed identity created in the previous step.
1. Click "Select".
1. Click "Review + assign".

> Do the same thing for the next 2 roles: "Monitoring contributor" and "Virtual Machine Contributor".

