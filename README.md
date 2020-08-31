# AzureNetworkSecurityDynamicIP
An Azure Function App, Azure Logic App, and Azure Automation Runbook to utilise a dynamic IP in Network Security Group Rules

### Requirements:
1. AzureRM.Network and AzureRM.Profile module in Azure Automation
   - In the Azure portal, open your Automation account.
   - Select Modules under Shared Resources to open the list of modules.
   - Click Browse gallery from the top of the page.
   - Search 'AzureRM.Network AzureRM.Profile'
   - Select each module and import it into your Azure Automation account.
   
2. Existing Network Security Group rule
  
3. Public DNS records

### Info:
1. [IPLookup.ps1](IPLookup.ps1) - template code for an Azure Function App which will query *public DNS* records for your FQDN
2. [UpdateNetworkSecurityGroupRule.ps1](UpdateNetworkSecurityGroupRule.ps1) - template code for Azure Automation Account runbook which will utilise the public DNS data to *update existing Network Security Group rule*.
3. [RunbookIntervalLogicApp](RunbookIntervalLogicApp) - Azure Automation Account schedules are limited to running at most 1 hour intervals. To work around this, we use an Azure Logic App to schedule runbook jobs at intervals of our choosing. I recommend no less than 5 minute intervals since runbook jobs take on average 1 minute to complete.

### Setup:
1. Create a Resource Group to contain your automation
2. Create an Azure Function App within the Resource Group
3. Add a new Function with your Function App, adapt the code in [IPLookup.ps1](IPLookup.ps1) template
4. Generate a Function Url for your function
5. Create an Azure Automation Account within the Resource Group
6. Create a Runbook within the Automation Account, adapt the code in [UpdateNetworkSecurityGroupRule.ps1](UpdateNetworkSecurityGroupRule.ps1) template
   - Add your Network Security Group name in line 26
   - Add your Resource Group name in line 28
   - Add your Network Security Rule name in line 30
   - Add your Function Url in line 32, *appending '&name=Lon' to the end*
   - Add your Priority in line 35
7. Create an Azure Logic App within the Resource Group
8. Import (and modify for your environment) the Logic App template using [RunbookIntervalLogicApp](RunbookIntervalLogicApp)
