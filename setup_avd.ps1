Write-Output "Attempting Azure AD Join..."
$JoinOutput = dsregcmd.exe /join
Write-Output $JoinOutput

# Install AVD agent
Invoke-WebRequest -Uri https://query.prod.cms.rt.microsoft.com/cms/api/am/binary/RWrmXv -OutFile "AVDAgent.msi"
Start-Process msiexec.exe -Wait -ArgumentList "/i AVDAgent.msi /quiet /qn /norestart"

# Install Boot Loader
Invoke-WebRequest -Uri https://query.prod.cms.rt.microsoft.com/cms/api/am/binary/RWrxrH -OutFile "AVDBootLoader.msi"
Start-Process msiexec.exe -Wait -ArgumentList "/i AVDBootLoader.msi /quiet /qn /norestart"

# Register the session host using the injected token
$token = "<REGISTRATION_TOKEN>"
Start-Process "C:\Program Files\Microsoft RDInfra\RDAgentBootLoader\RDAgentBootLoader.exe" -ArgumentList $token -Wait
