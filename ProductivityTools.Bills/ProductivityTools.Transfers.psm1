. "$PSScriptRoot\App\TransfersProvider.ps1"
. "$PSScriptRoot\App\Database.ps1"
. "$PSScriptRoot\App\Element.ps1"

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

function GetCategories{
	[cmdletbinding()]
	param()
	
	$categories=Get-MasterConfiguration -Key TransfersCategories
	$categoriesArray=$categories.Split(",")
	return $categoriesArray
}


function Print-AllTransfers{

	[cmdletbinding()]
	param(
		[switch]$SaveToDatabase
	)

	$categoriesArray=GetCategories
	foreach($category in $categoriesArray)
	{
		$transfers=GetTransfers $category
		Print $transfers
		Write-Output ""

		if($SaveToDatabase.IsPresent)
		{
			SaveToDB $category
		}
	}
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
	[cmdletbinding()]
	param()

	$categoriesArray=GetCategories
	foreach($category in $categoriesArray)
	{
		SaveToDB $category
	}
}