- [workdev-alst-PLM](#workdev-alst-plm)
  - [Create a resource group to host PLM monitoring resources.](#create-a-resource-group-to-host-plm-monitoring-resources)
    - [Basics blade](#basics-blade)
    - [Tags blade](#tags-blade)
    - [Review + Create blade](#review--create-blade)
  - [Create user managed identity in azure](#create-user-managed-identity-in-azure)
    - [home tab](#home-tab)
    - [basic tab](#basic-tab)
    - [Tags tab](#tags-tab)
    - [Review + Create blade](#review--create-blade-1)
  - [Assign the user managed identity to the resource group hosting the PLM VMs](#assign-the-user-managed-identity-to-the-resource-group-hosting-the-plm-vms)
    - [role tab](#role-tab)
    - [Members tab](#members-tab)
    - [Review + assign tab](#review--assign-tab)
  - [Assign the user managed identity to the resource group hosting the Log Analytics workspace](#assign-the-user-managed-identity-to-the-resource-group-hosting-the-log-analytics-workspace)
    - [role tab](#role-tab-1)
    - [Members tab](#members-tab-1)
    - [Review + assign tab](#review--assign-tab-1)
  - [Create a Log Analytics workspace](#create-a-log-analytics-workspace)
    - [home tab](#home-tab-1)
    - [basic tab](#basic-tab-1)
    - [Tags blade](#tags-blade-1)
  - [Create a data collection rule for the Log Analytics workspace](#create-a-data-collection-rule-for-the-log-analytics-workspace)
    - [home](#home)
    - [Basics blade](#basics-blade-1)
    - [Resources blade](#resources-blade)
    - [Collect and Deliver blade](#collect-and-deliver-blade)


# workdev-alst-PLM 

## Create a resource group to host PLM monitoring resources.

1. Navigate to the Azure portal.
2. In the search top bar type “**resource groups**”.
3. Click “**resource groups**”.
4. Click “**+ Create**”.

### Basics blade

1. Select the subscription.
1. Type a name for the resource group
1. Select a region. 
1. Click “**Next: Tags**”. 

### Tags blade

1. Set the tags
1. click “**Review + create**”.

### Review + Create blade

1. Check the configuration
1. click "**create**".

## Create user managed identity in azure

it is recommended to use user managed identity tio simplify deployment of the solution when you do not permission to create system assigned managed identity.

### home tab

1. Navigate to the Azure portal.
2. From home click “**Create a resource**”.
3. Search for “**Managed Identity**”.
4. Select “**User Assigned Managed Identity**”.
5. and click “**Create**”.

### basic tab

1. Select the subscription and resource group.
1. Select the "**region**".
1. chose a **name** for the identity.
1. Click "**Next : Tags**".

### Tags tab

1. Enter any required tags
1. click "**Next : Review + create**".

### Review + Create blade

1. Check the configuration
1. click "**create**".

## Assign the user managed identity to the resource group hosting the PLM VMs

Lets start by the PLM VMs resource group and assign the "Virtual Machine Contributor" role to the user managed identity.

1. Navigate to the Azure portal.
1. Select **"resource groups"** from the left menu.
1. Select the resource group hosting the PLM VMs 
1. select **"Access control (IAM)"** from the left menu.
1. Click **"Add"** and select **"Add role assignment"**.

### role tab

1. in the search box type **"virtual machine contributor"**.
1. select **"Virtual Machine Contributor"**.
1. click **"Next"**.

### Members tab

1. Assign access to, select **"Managed Identity"**.
1. click **"Select members"**.
1. select the **"subscription"**.
1. Managed identity drop down, select the "**user managed identity**".
1. Select the managed identity created in the previous step.
1. Click "**Select**".
1. Click "**Review + assign**".

### Review + assign tab

1. click "**Review + assign**".

## Assign the user managed identity to the resource group hosting the Log Analytics workspace

Continue start by the newly created resource group for the monitoring resources and assign the "Log Analytics Contributor" role to the user managed identity.

1. Navigate to the Azure portal.
1. Select "**resource groups**" from the left menu.
1. Select the **resource group** hosting the PLM VMs. 
1. select "**Access control (IAM)**" from the left menu.
1. Click "**Add**" and select "**Add role assignment**".

### role tab

1. in the search box type **"Log Analytics Contributor"**.
1. select "**Log analytics Contributor**".
1. click "**Next**".

### Members tab

1. Assign access to, select "**Managed Identity**".
1. click "**Select members**".
1. select the **subscription**.
1. In managed identity drop down, select the "**user managed identity**".
1. Select the managed identity created in the previous step.
1. Click "**Select**".
1. Click "**Review + assign**".

### Review + assign tab

1. click "**Review + assign**".
1. 
> Do the same thing for the next roles: "**Monitoring contributor**".

## Create a Log Analytics workspace

### home tab

1. Navigate to the Azure portal.
2. From home click “**Create a resource**”.
3. Search for “**log analytics**”.
4. Select “**Log Analytics Workspace**”.
5. and click “**Create**”.

### basic tab

1. Select or create a resource group.
1. Give a name to your log analytics workspace following your naming convention.
1. Select the region.
1. Click “**Next**”.

### Tags blade

1. Add required tags.
1. Click “**Review + Create**”.
1. Click “**Create**”.

## Create a data collection rule for the Log Analytics workspace

### home

1. Navigate to the Azure portal.
1. Select “Monitoring” on the left menu.
1. Select “Data Collection Rules”.
1. Click “+ Create”.

### Basics blade

1. Define a Rule Name, Subscription, RG to host the DCR.
1. Platform type select “Windows”.
1. For “Data Collection Endpoint” left none.

### Resources blade

1. Click “+ Add Resources”.
1. Resource group select the PLM resource groups.
1. Resource types select “Virtual Machines”.
1. Locations select “All locations”.
1. Click “Apply”

### Collect and Deliver blade

1. Click “+ Add data source”.
1. In “Data source type” select “Performance counters”.
1. Keep “Basic” as selection.
1. Set “Sample rate (seconds)” to “5” for each.
1. Select “Destination” tab.
1. Click “+ Add destination”.
1. In drop down list “Specifies destination type” select “Azure Monitor Logs”.
1. Select the subscription.
1. In the drop-down list “Select a Workspace” select the log analytics workspace created before.
1. Delete the “Azure Monitor Metrics (preview)” line.
1. Click the “Save” button.
1. Click “Next Review and Create”.
1. Click “Create”.
