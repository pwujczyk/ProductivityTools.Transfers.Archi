. "$PSScriptRoot\App\TransfersProvider.ps1"
. "$PSScriptRoot\App\Database.ps1"

function Print{
	[cmdletbinding()]
	param(
	$model
	)
	
	Write-Output $model.Name
	[decimal]$sum=0
	foreach($element in $model.Elements)
	{
		#Write-Output $element 
		$sum+=$element.Value
	}
	Write-Output $model.Elements |Format-Table -Autosize
	Write-Output $sum
}


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

function SaveToDB{
	[cmdletbinding()]
	param(
		[string]$name
	)
	$transfers=GetTransfers $name
	SaveToDatbase -category "$name" -model $transfers
}

function Save-AllTransfersToDB{
	SaveToDB Proxy
	SaveToDB ProxyKameralne
	SaveToDB Niechorze
	SaveToDB Pensja
	SaveToDB Proxy
}