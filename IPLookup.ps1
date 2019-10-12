using namespace System.Net

# Input bindings are passed in via param block.
param($Request, $TriggerMetadata)

# Write to the Azure Functions log stream.
Write-Host "PowerShell HTTP trigger function processed a request."

# get IP only, strip all other columns, strip header
$Dyn_IP_siteA = Resolve-DnsName -Name siteA.domain.com -Type A -DnsOnly | Select IPAddress -ExpandProperty IPAddress

# Require a query parameter/value as a layer of abstraction/variability. This is not necessary but a) ensures anyone with your function URL has to know a parameter and its possible values, b) allows you to expand the function for multiple values.
$name = $Request.Query.Name
if (-not $name) {
    $name = $Request.Body.Name
}

if ($name -eq "Office1") {
    $status = [HttpStatusCode]::OK
    $body = $Dyn_IP_siteA
}
else {
    $status = [HttpStatusCode]::BadRequest
    $body = "Bad Request Logged"
}

# Associate values to output bindings by calling 'Push-OutputBinding'.
Push-OutputBinding -Name Response -Value ([HttpResponseContext]@{
    StatusCode = $status
    Body = $body
})
