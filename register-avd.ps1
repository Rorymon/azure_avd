# register-avd.ps1
$token = "<REGISTRATION_TOKEN>" # will be templated by Terraform

Invoke-WebRequest -Uri https://query.prod.cms.rt.microsoft.com/cms/api/am/binary/RWrmXv -OutFile "AVDAgent.msi"
Start-Process msiexec.exe -Wait -ArgumentList "/i AVDAgent.msi /quiet /norestart"

Invoke-WebRequest -Uri https://query.prod.cms.rt.microsoft.com/cms/api/am/binary/RWrxrH -OutFile "AVDBootLoader.msi"
Start-Process msiexec.exe -Wait -ArgumentList "/i AVDBootLoader.msi /quiet /norestart"

Start-Process "C:\Program Files\Microsoft RDInfra\RDAgentBootLoader\RDAgentBootLoader.exe" -ArgumentList $token -Wait
