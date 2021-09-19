Class Element
{
    [String]$Name
    static [int]$numberOfWheels = 4
    [System.Collections.ArrayList]$Elements=@()
    [Decimal]$value
    [int]$TransferDay
}


function FindBusinessService{
	[cmdletbinding()]
	param(
	[string]$Path,
	[string]$Name
	)
	
	$xmlsFiles=Get-ChildItem $Path -Recurse 
	foreach($xmlFile in $xmlsFiles)
	{
		[xml]$xml=Get-Content $xmlFile.FullName
		if( $xml.BusinessService.name -eq $Name)
		{
			return $xml.BusinessService.id
		}
	}
}

function FindElementName{
	[cmdletbinding()]
	param(
	[string]$Path,
	[string]$id
	)
	
	
	$xmlsFiles=Get-ChildItem $Path -Recurse 
	foreach($xmlFile in $xmlsFiles)
	{
		[xml]$xml=Get-Content $xmlFile.FullName
		if( $xml.BusinessService.id -eq $id)
		{
			return $xml.BusinessService.name
		}
	}
}

function GetProperty{
	[cmdletbinding()]
	param(
	$node,
	$name
	)
	
	$properties=$node.properties
	foreach($property in $properties)
	{
		if($property.key -eq $Name)
		{
			return $property.Value
		}
	}
}

function FindTransfersFromId{
	[cmdletbinding()]
	param(
	[string]$Path,
	[string]$Id
	)
	[System.Collections.ArrayList]$elements=@()
	
	$xmlsFiles=Get-ChildItem $Path -Recurse 
	foreach($xmlFile in $xmlsFiles)
	{
		[xml]$xml=Get-Content $xmlFile.FullName
		if($xml.TriggeringRelationship -ne $null)
		{
			foreach($node in $xml.ChildNodes)
			{
				$source=$xml.TriggeringRelationship.source
				$sourceHref=$source.href
				$sourceId=$sourceHref.Substring($sourceHref.IndexOf('#')+1)
				if ($sourceId -eq $Id)
				{
					
					$element=New-Object Element
					$x=$elements.Add($Element)
					$textValue=GetProperty $node "Value"
					[decimal]$element.Value=$textValue.Replace(',','.')
					$element.TransferDay=GetProperty $node "TransferDay"
					
					$target=$xml.TriggeringRelationship.target
					$targetHref=$target.href
					$targetIdId=$targetHref.Substring($targetHref.IndexOf('#')+1)
					$element.Name=FindElementName $Path $targetIdId
				}
			}
		}
	}
	return $elements
}


function GetTransfers{

	[cmdletbinding()]
	param(
	$Name
	)
	$modelPath="d:\BitBucket\home.archi\model\*.xml"
	
	$core=New-Object Element
	$core.Name=$Name
	$sallaryId=FindBusinessService $modelPath $core.Name
	$core.Elements=FindTransfersFromId $modelPath $sallaryId
	return $core
}