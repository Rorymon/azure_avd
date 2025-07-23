# Azure Entra ID Join
Write-Host "Starting Azure Entra ID Join..."
dsregcmd /join

# Wait briefly to allow join process to complete
Start-Sleep -Seconds 20

# Install AVD Agent
Write-Host "Downloading AVD Agent..."
Invoke-WebRequest -Uri "https://query.prod.cms.rt.microsoft.com/cms/api/am/binary/RWrmXv" -OutFile "AVDAgent.msi"

Write-Host "Installing AVD Agent..."
Start-Process msiexec.exe -Wait -ArgumentList "/i AVDAgent.msi /quiet /qn /norestart"

# Install Bootloader
Write-Host "Downloading AVD Bootloader..."
Invoke-WebRequest -Uri "https://query.prod.cms.rt.microsoft.com/cms/api/am/binary/RWrxrH" -OutFile "AVDBootLoader.msi"

Write-Host "Installing Bootloader..."
Start-Process msiexec.exe -Wait -ArgumentList "/i AVDBootLoader.msi /quiet /qn /norestart"

# Register VM to host pool
Write-Host "Registering with AVD Host Pool..."
$token = "<REGISTRATION_TOKEN>"
$bootloader = "C:\Program Files\Microsoft RDInfra\RDAgentBootLoader\RDAgentBootLoader.exe"

if (Test-Path $bootloader) {
    Start-Process $bootloader -ArgumentList $token -Wait
    Write-Host "Registration command sent to BootLoader."
} else {
    Write-Host "Bootloader not found. Ensure the AVD Bootloader installed correctly."
}
