# workdev-alst-PLM 

## Test deployment check list and outputs

- [ ] Deploy Log analytics.
- [ ] Deploy user assigned mnaged identity (uami).
- [ ] Configure RBAC for uami previously created.
    -  [ ] "Virtual machine crontributor" assigned to VM RG(s).
    -  [ ] "log analytics contributor" and "Monitor Contributor" assigned to RG hosting the log analytics workspace.
- [ ] Deploy Linux VM before creating the DCR.
- [ ] Deploy Windows VM before creating the DCR.
- [ ] Check VMs does not have the monitoring agent deployed.
- [ ] Create the DCR.
- [ ] Check if VMs have the monitoring agent deployed.

> output: AMA deployed on Windows VM, but not on Linux. in activity log of Windows you can see create or update DCR association + Virtual machine extension.

- [ ] Deploy Windows VM after creating the DCR and before creating the policy to assign the DCR.
- [ ] Check on the newly created if VMs have the monitoring agent deployed.

> output: Monitoring agent is not deployed as expected. 

- [ ] Create the policy to assign the DCR.
- [ ] Assign the policy to the RG by selecting the subscription where the RG are hosted + excluding the RGs not in the scope.
- [ ] Check on the newly created if VMs have the monitoring agent deployed.

> output: the policy is compliant including the VMs from before and after the DCR creation, but AMA is not deplyed and post DCR creation VM does not report in log analytics workspace. 

- [ ] Create custom policy to deploy AMA.
- [ ] Assign custom policy to RG by selecting the subscription where the RG are hosted + excluding the RGs not in the scope.

> the assignment contains a remediation task that should remediate all the VMs where AMA is not deployed.

- [ ] Check if all VM have AMA deployed and report to log analytics workspace. 
- [ ] Deploy Windows VM after AMA policy creation and assignment.

## Create a resource group to host PLM monitoring resources

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

## Create User Managed Identity in azure

it is recommended to use user managed identity to simplify deployment of the solution when you do not have permission to create system assigned managed identity.

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

## Assign user managed identity permissions to the resource group hosting the Log Analytics workspace

> note: it could be the same resource group than the Virtual Machine or a different, it does not matter.

Assign the "Log Analytics Contributor" role to the user managed identity.

> at this stage you do not have yet deployed the log analytics workspace, just select the resource group where it is going to be deployed.

1. Navigate to the Azure portal.
1. Select "**resource groups**" from the left menu.
1. Select the **resource group** hosting the PLM Log analytics workspace. 
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
 
> Do the same thing for the next roles: "**Monitoring contributor**".

> in my case I deploy VM and log analytics workspace in the same RG
> checking the access to that RG I've got the following setup 
> ![Virtual machine](image-1.png)
> ![log analytics](image-2.png)

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
1. Select “**Monitoring**” on the left menu.
1. Select “**Data Collection Rules**”.
1. Click “**+ Create**”.

### Basics blade

1. Define a "**Rule Name**", "**Subscription**", "**RG**" to host the DCR.
2. Select the same "**Region**" as the Log Analytics workspace.
3. Platform type select “**Windows**”.
4. For “**Data Collection Endpoint**” left none.
5. Click "**Next: Resources**".

### Resources blade

1. Click “**+ Add Resources**”.
1. in the search box type the name of the resource group hosting the PLM VMs.
2. Select the resource group.
3. Click “**Apply**”.
4. Click "**Next: Collect and Deliver**".

### Collect and Deliver blade

1. Click “**+ Add data source**”.
1. In “**Data source type**” select “**Performance counters**”.
1. Keep “**Basic**” as selection.
1. Keep “**Sample rate (seconds)**” to “**60**” for each.
1. Select “**Next: Destination**” tab.
1. Click “**+ Add destination**”.
1. In drop down list “**Specifies destination type**” select “**Azure Monitor Logs**”.
1. Select the subscription.
1. In the drop-down list “**Select a Workspace**” select the log analytics workspace created before.
1. Delete the “**Azure Monitor Metrics (preview)**” line.
1. Click the “**Add data source**” button.
1. Click “**Next Review + Create**”.

### Review + Create blade

1. Click “Create”.

## Create custom policy to assign AMA

1. Navigate to the Azure portal.
2. In the top search bar type “**Policy**”.
3. Click on “**Policy**”.
4. On the left policy menu blade select “**Definitions**”.
5. In the search type “**Configure Windows virtual machines to run Azure Monitor Agent **“.
6. Out of the 2 select the one using the **user assigned managed identity**.
7. Click “**Duplicate definition**”.
8. For “**Definition Location**” click "**...**" at the end of input field.
9. select the subscription(s) you are going to assign the policy to and click "**Select**".
10. Change name according to your naming convention, it will be good to add “**Custom - **” in the front. It will help to search it for the assignment.
11. Add the following to the description “**the option "evaluationDelay": "AfterProvisioning" added to the policy to have AMA deployed straight after deployment of the VM.**”
12. For the category section I would recommend to keep the existing “**Monitoring**” but a new category can be created.
13. In the properties.parameters section, add the following code, after the “effect” definition.
    ```json
   		"evaluationDelay": {
			"type": "String",
			"metadata": {
				"displayName": "Evaluation Delay",
				"description": "set the evaluation delay of the policy ."
			},
			"allowedValues": [
				"AfterProvisioning",
				"AfterProvisioningSuccess",
				"PT1M"
			],
			"defaultValue": "AfterProvisioning"
		},
    ```
14. In the properties.policyRule.then.details section, add the following code.
    ```json
    "evaluationDelay": "[parameters('evaluationDelay')]",
    ```
15. In role definition field keep "**Virtual Machine Contributor**".
1. Click the “**Save**” button.

## Assign the created policy to deploy AMA

1. Navigate to the Azure portal.
2. In the top search bar type “**Policy**”.
3. Click on “**Policy**”.
4. On the left policy menu blade select “**Assignments**”.
5. Click “**Assign policy**”,

### Basics blade

1. For “**Scope**” click "**...**" at the end of input field. Choose the “**subscription**” and the "**resource group(s)**" you want the policy to be assigned to. Click "**Select**".
2. Do not set anything for “**Exclusions **“.
3. In policy definition click "**...**" at the end of input field, in the search bar type “Custom -“. Select the revealed policy, and click “**Add**”.
4. In the description field add “**Policy assignment to deploy azure monitoring agent (AMA) just after VM provisioning in the chosen RG**”
5. Keep policy enforcement to “Enabled”.
6. Click “**Next**”.

### Advanced blade

1. Nothing to change click “**Next**”.

### Parameters blade

1. Untick "**Only show parameters...**".
2. Choose “**true**” in the drop down list for managed identity.
3. in the "**User-Assigned Managed Identity Name**" past the name of the user managed identity created before.
4. in the field "**User-Assigned Managed Identity Resource Group**" past the name of the resource group hosting the user managed identity.
5. Click “**Next**”.

### Remediation blade

1. Click to enable “**Create a remediation task**”.
2. For "**Type of managed identity**" select "**User assigned...**".
3. For “**Scope**” click "**...**" at the end of input field. Choose the “**subscription**” and the "**resource group(s)**" where the user assigned managed identity created before is hosted. Click "**Select**".
4. In the drop-down field "**Existing user assigned managed identity**" select the user assigned managed identity created before.
5. click "**Nest**".

### Non-compliance message blade

1. Type a non compliance message.
2. Click “**Next**”.

### Review + Create blade

1. review the configuration.
2. click "**Create**".

## Create custom policy to assign Data Collection Rule

1. Navigate to the Azure portal.
2. In the top search bar type “**Policy**”.
3. Click on “**Policy**”.
4. On the left policy menu blade select “**Definitions**”.
5. In the search type “**Configure Windows Virtual Machines to be associated with a Data Collection Rule or a Data Collection Endpoint**“.
1. Select the policy “**Configure Windows Virtual Machines to be associated with a Data Collection Rule or a Data Collection Endpoint**“. 
1. Click “**Duplicate definition**”.
1. For “**Definition Location**” click "**...**" at the end of input field. Select the subscription(s) you are going to assign the policy to and click "**Select**".
1.  Change name according to your naming convention, it will be good to add “**Custom - **” in the front. It will help to search it for the assignment.
1.  Add the following to the description “**the option "evaluationDelay": "AfterProvisioning" added to the policy to have DCR deployed straight after deployment of the VM.**”
1. For the category section I would recommend to keep the existing “**Monitoring**” but a new category can be created.
1. In the properties.parameters section, add the following code, after the “effect” definition.
    ```json
    "evaluationDelay": {
        "type": "String",
        "metadata": {
            "displayName": "Evaluation Delay",
            "description": "set the evaluation delay of the policy ."
        },
        "allowedValues": [
            "AfterProvisioning",
            "AfterProvisioningSuccess",
            "PT1M"
        ],
        "defaultValue": "AfterProvisioning"
        },
    ```
1. In the properties.policyRule.then.details section, change the following code.
    ```json
    "evaluationDelay": "AfterProvisioning",
    ```
    by
    ```json
    "evaluationDelay": "[parameters('evaluationDelay')]",
    ```
1. For Role definitions, the following 2 roles should be selected "**Log Analytics Contributor**" and "**Monitor Contributor**".
1. Click the “**Save**” button.

## Assign the created policy to deploy the Data Collection Rule

1. Navigate to the Azure portal.
2. In the top search bar type “**Policy**”.
3. Click on “**Policy**”.
4. On the left policy menu blade select “**Assignments**”.
5. Click “**Assign policy**”,

### Basics blade

1. For “**Scope**” click "**...**" at the end of input field. Choose the “**subscription**” and the "**resource group**" you want the policy to be assigned to. Click "**Select**".
2. Do not set anything for “**Exclusions**“.
3. In policy definition click "**...**" at the end of input field, in the search bar type “**Custom -**“. Select the revealed policy, and click “**Add**”.
4. In the description field add “**Policy assignment to deploy azure monitoring agent (AMA) just after VM provisioning in the chosen RG**”
5. Keep policy enforcement to “**Enabled**”.
6. Click “**Next**”.

### Advanced blade

1. Nothing to change click “**Next**”.

### Parameters blade

1. in the field "**Data Collection Rule Resource ID...***" past the resource ID of the data collection rule created before.
    Easiest way to get the resource ID is to https://learn.microsoft.com/en-us/rest/api/monitor/data-collection-rules/get?tabs=HTTP try to run the get request and copy the resource ID from the response.
    or execute the following az cli command provided the rg name where the DCR is deployed
    ```azurecli
    az monitor data-collection rule list -g <RG Name>
    ``````
2. Click “**Next**”.

### Remediation blade

1. Click to enable “**Create a remediation task**”.
2. For "**Type of managed identity**" select "**User assigned...**".
3. For “**Scope**” click "**...**" at the end of input field. Choose the “**subscription**” . Click "**Select**".
> At this stage do not select any optinal RG, the remediation task will be assigned to the whole selected subscription
1. In the drop-down field "**Existing user assigned managed identity**" select the user assigned managed identity created before.
1. click "**Next**".

### Non-compliance message blade

1. Type a non compliance message.
2. Click “**Next**”.

### Review + Create blade

1. review the configuration.
2. click "**Create**".

## Conclusions

- At this stage any existing VM in the PLM VMs resource group(s) will have the AMA deployed and the DCR assigned.
- Any new VM deployed in the PLM VMs resource group(s) will have the AMA deployed and the DCR assigned straight after the VM provisioning.

you can verify it by navigating to the Azure portal. 
- Select "**Monitoring**" on the left menu. 
- Select "**Data Collection Rules**". 
- Select the DCR created before. 
- In the “**Resources**” blade you should see the VMs from the PLM VMs resource group(s).

## Kusto query example to retrieve data points

### performance counters

```kusto
// Logical Disk C:
Perf 
| where ObjectName == "LogicalDisk" 
| where CounterName == "Avg. Disk Queue Length"
| where InstanceName =="C:"
| project TimeGenerated, Computer, CounterName, CounterValue
| summarize by TimeGenerated, Computer, CounterValue
| render timechart

Perf 
| where ObjectName == "LogicalDisk" 
| where CounterName == "Current Disk Queue Length"
| where InstanceName =="C:"
| project TimeGenerated, Computer, CounterName, CounterValue
| summarize by TimeGenerated, Computer, CounterValue
| render timechart

Perf 
| where ObjectName == "LogicalDisk" 
| where CounterName == "Avg. Disk sec/Read"
| where InstanceName =="C:"
| project TimeGenerated, Computer, CounterName, CounterValue
| summarize by TimeGenerated, Computer, CounterValue
| render timechart

Perf 
| where ObjectName == "LogicalDisk" 
| where CounterName == "% Disk Read Time"
| where InstanceName =="C:"
| project TimeGenerated, Computer, CounterName, CounterValue
| summarize by TimeGenerated, Computer, CounterValue
| render timechart


Perf 
| where ObjectName == "LogicalDisk" 
| where CounterName == "% Disk Write Time"
| where InstanceName =="C:"
| project TimeGenerated, Computer, CounterName, CounterValue
| summarize by TimeGenerated, Computer, CounterValue
| render timechart

// Process
Perf 
| where ObjectName == "Process" 
| where CounterName == "IO Read Bytes/sec"
| project TimeGenerated, Computer, CounterName, CounterValue
| summarize by TimeGenerated, Computer, CounterValue
| render timechart

Perf 
| where ObjectName == "Process" 
| where CounterName == "IO Write Bytes/sec"
| project TimeGenerated, Computer, CounterName, CounterValue
| summarize by TimeGenerated, Computer, CounterValue
| render timechart

// Processor information 
Perf 
| where ObjectName == "Processor information" 
| where CounterName == "% Processor Time"
| project TimeGenerated, Computer, CounterName, CounterValue
| summarize by TimeGenerated, Computer, CounterValue
| render timechart

// System
Perf 
| where ObjectName == "System" 
| where CounterName == "Processor Queue Length"
| project TimeGenerated, Computer, CounterName, CounterValue
| summarize by TimeGenerated, Computer, CounterValue
| render timechart

Perf 
| where ObjectName == "System" 
| where CounterName == "Processes"
| project TimeGenerated, Computer, CounterName, CounterValue
| summarize by TimeGenerated, Computer, CounterValue
| render timechart
```
