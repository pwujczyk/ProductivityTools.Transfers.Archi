Clear-Host
Set-Location $PSScriptRoot
Import-Module .\ProductivityTools.Transfers.psm1 -Force 


 Print-AllTransfers

#Save-AllTransfersToDB -verbose