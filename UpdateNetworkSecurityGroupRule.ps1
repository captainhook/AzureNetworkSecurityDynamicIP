# Authenticate with Azure
$connectionName = "AzureRunAsConnection"
try
{
    # Get the connection "AzureRunAsConnection "
    $servicePrincipalConnection=Get-AutomationConnection -Name $connectionName         

    "Logging in to Azure..."
    Add-AzureRmAccount `
        -ServicePrincipal `
        -TenantId $servicePrincipalConnection.TenantId `
        -ApplicationId $servicePrincipalConnection.ApplicationId `
        -CertificateThumbprint $servicePrincipalConnection.CertificateThumbprint 
}
catch {
    if (!$servicePrincipalConnection)
    {
        $ErrorMessage = "Connection $connectionName not found."
        throw $ErrorMessage
    } else{
        Write-Error -Message $_.Exception
        throw $_.Exception
    }
}

# set Network Security Group name
$NetSecGrp = ""
# set Resource Group name
$ResGrp = ""
# set Network Security Group Rule name
$NetSecRul = ""
# get and store the IP using our Azure Function App's URL
$Dyn_IP = Invoke-WebRequest -URI "https://….azurewebsites.net/api/…&name=Office1" -UseBasicParsing -Method Get

# Get the network security group
$nsg = Get-AzureRmNetworkSecurityGroup -Name $NetSecGrp -ResourceGroupName $ResGrp
# Use the pipeline operator to pass the security group in $nsg to Get-AzureRmNetworkSecurityRuleConfig (the security rule configuration)
$nsg | Get-AzureRmNetworkSecurityRuleConfig -Name $NetSecRul
# Update the network security rule
Set-AzureRmNetworkSecurityRuleConfig -Name $NetSecRul -NetworkSecurityGroup $nsg -Access "Allow" -DestinationAddressPrefix * -DestinationPortRange 22 -Direction Inbound -Priority 350 -Protocol * -SourceAddressPrefix $Dyn_IP -SourcePortRange *  | Set-AzureRmNetworkSecurityGroup
