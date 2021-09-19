function SaveToDatbase(){
	[cmdletbinding()]
	param(
		[string]$category,
		[Element]$model
	)

	Write-Verbose "Push $category transfers to database"
	$sqlInstance=Get-MasterConfiguration -Key TransfersSqlInstance
	$databaseName=Get-MasterConfiguration -Key TransfersDatabse
	$date=Get-Date

	$deleteAllQuery="DELETE FROM [Transfer] WHERE DATE='$date' and Category='$category'"
	
	Invoke-SQLQuery -SqlInstance $sqlInstance -DatabaseName $databaseName -Query $deleteAllQuery 

	foreach($element in $model.Elements){
			
			$query="Insert into [Transfer](Date,Category,Name,Value) VALUES ('$date','$category','$($element.Name)',$($element.value))"
			Invoke-SQLQuery -SqlInstance $sqlInstance -DatabaseName $databaseName -Query $query 
	}
}