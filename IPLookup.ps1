using namespace System.Net

# Input bindings are passed in via param block.
param($Request, $TriggerMetadata)

# Write to the Azure Functions log stream.
Write-Host "PowerShell HTTP trigger function processed a request."

# get IP
$Dyn_IP = Resolve-DnsName -Name domain.com -Type A -DnsOnly | Select IPAddress -ExpandProperty IPAddress

# Interact with query parameters or the body of the request.
$name = $Request.Query.Name
if (-not $name) {
    $name = $Request.Body.Name
}

if ($name -eq "someName") {
    $status = [HttpStatusCode]::OK
    $body = $Dyn_IP
}
else {
    $status = [HttpStatusCode]::BadRequest
    $body = "Bad Request."
}

# Associate values to output bindings by calling 'Push-OutputBinding'.
Push-OutputBinding -Name Response -Value ([HttpResponseContext]@{
    StatusCode = $status
    Body = $body
})
