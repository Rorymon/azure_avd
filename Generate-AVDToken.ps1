param (
    [Parameter(Mandatory = $false)]
    [string]$SubscriptionId = $env:AZURE_SUBSCRIPTION_ID,

    [string]$ResourceGroup  = "AVDEU",
    [string]$HostPoolName   = "avd-hostpool",
    [string]$Location       = "northeurope",
    [string]$OutputPath     = ".\\avd_token.json"
)

# Validate input
if (-not $SubscriptionId) {
    Write-Error "Subscription ID not provided. Set the AZURE_SUBSCRIPTION_ID environment variable or pass it as a parameter."
    exit 1
}

$ExpiryDate = (Get-Date).AddDays(7).ToString("yyyy-MM-ddTHH:mm:ssZ")

# Login and set context
Write-Host "Using subscription: $SubscriptionId" -ForegroundColor Cyan
az account set --subscription $SubscriptionId

# Generate token
Write-Host "Creating registration token for Host Pool: $HostPoolName" -ForegroundColor Cyan
$tokenJson = az desktopvirtualization hostpool create-registration-token `
  --resource-group $ResourceGroup `
  --hostpool-name $HostPoolName `
  --location $Location `
  --expiration $ExpiryDate `
  --output json

if ($LASTEXITCODE -ne 0) {
    Write-Error "Failed to create registration token"
    exit 1
}

# Write token file
$tokenJson | Out-File -Encoding utf8 -FilePath $OutputPath
Write-Host "✅ Registration token saved to $OutputPath" -ForegroundColor Green
