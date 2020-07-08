# AzureNetworkSecurityDynamicIP
An Azure Function App and Azure Automation Runbook to utilise a dynamic IP in Network Security Group Rules

### Requirements:
1. AzureRM.Network and AzureRM.Profile module in Azure Automation
   - In the Azure portal, open your Automation account.
   - Select Modules under Shared Resources to open the list of modules.
   - Click Browse gallery from the top of the page.
   - Search 'AzureRM.Network AzureRM.Profile'
   - Select each module and import it into your Azure Automation account.
  
2. Public DNS records
