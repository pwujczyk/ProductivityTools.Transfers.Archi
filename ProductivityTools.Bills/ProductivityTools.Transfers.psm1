. "$PSScriptRoot\App\TransfersProvider.ps1"

function Print-AllTransfers{
	$transfers=GetTransfers Proxy
	Print $transfers
	Write-Output ""

	$transfers=GetTransfers ProxyKameralne
	Print $transfers
	Write-Output ""

	$transfers=GetTransfers Niechorze
	Print $transfers
	Write-Output ""

	$transfers=GetTransfers Pensja
	Print $transfers
	Write-Output ""
}