Write-Output "Attempting Azure AD Join..."
$JoinOutput = dsregcmd.exe /join
Write-Output $JoinOutput
