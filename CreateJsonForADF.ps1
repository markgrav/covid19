####$__conn = Connect-CrmOnlineDiscovery -InteractiveMode
##$__entities = Get-CrmEntityAllMetadata -conn $__conn -EntityFilters Entity

###$__field = Get-CrmEntityAttributeMetadata -conn $__conn -EntityLogicalName contact -FieldLogicalName contactid  -ErrorAction SilentlyContinue

###ForEach ($__entity in $__entities) {  
###   $__records = Get-CrmRecords -conn $__conn -EntityLogicalName $__entity.LogicalName -TopCount 1 -ErrorAction SilentlyContinue -WarningAction Ignore
   ###if ($__records.Count -gt 0) {
      ###"$($__entity.LogicalName)"
   ###}
###}


$__entityname = "picklistmapping"
$__fields = Get-CrmEntityAttributes -EntityLogicalName $__entityname
$__fields | Select-Object LogicalName,AttributeType | Out-File -FilePath "c:\temp\$($__entityname)Metadata.txt"
$__records = Get-Content -Path "c:\temp\$($__entityname)Metadata.txt" | Select-Object -Skip 3
$__ordinal = 0
$__datalake = @()
$__sql = @()
ForEach ($__record in $__records) {
   $__attributes = $__record.Split(" ")
   $__crmdatatype = $null

   ##"$($__attributes[0]) : $($__attributes[$__attributes.Length - 1])"

   switch ($__attributes[$__attributes.Length - 1]) {
      "Memo" {$__crmdatatype = "String" ; break}
      "Picklist" {$__crmdatatype = "Int32" ; break}
      "Virtual" {$__crmdatatype = "String" ; break}
      "String" {$__crmdatatype = "String" ; break}
      "DateTime" {$__crmdatatype = "DateTime" ; break}
      "Uniqueidentifier" {$__crmdatatype = "Guid" ; break}
      "Boolean" {$__crmdatatype = "Boolean" ; break}
      "Integer" {$__crmdatatype = "Int32" ; break}

      "Double" {$__crmdatatype = "Double" ; break}

      "Lookup" {$__crmdatatype = "Guid" ; break}

      "BigInt" {$__crmdatatype = "Int32" ; break}

      "Money" {$__crmdatatype = "Double" ; break}

      "Decimal" {$__crmdatatype = "Decimal" ; break}

      "Status" {$__crmdatatype = "Int32" ; break}

      "State" {$__crmdatatype = "Int32" ; break}

   }

   if ($__crmdatatype -ne $null) {
      $__ordinal++

      $__field = "{`"source`": {`"name`": `"$($__attributes[0])`",`"type`": `"$($__crmdatatype)`"},`"sink`": {`"type`": `"$($__crmdatatype)`",`"ordinal`": $($__ordinal)}}"
      $__datalake += $__field

      $__field = "{`"source`": {`"type`": `"$($__crmdatatype)`",`"ordinal`": $($__ordinal)},`"sink`": {`"name`": `"$($__attributes[0])`",`"type`": `"$($__crmdatatype)`"}}"
      $__sql += $__field

   }


}

"{`"type`": `"TabularTranslator`",`"mappings`": [" + ($__datalake -join ",") + "]}" | Out-File -FilePath "c:\temp\$($__entityname)DataLakeFields.txt"
"{`"type`": `"TabularTranslator`",`"mappings`": [" + ($__sql -join ",") + ",{`"source`":{`"type`":`"DateTime`",`"name`":`"InsertUtcDatetime`"},`"sink`":{`"name`":`"InsertUtcDatetime`",`"physicalType`":`"datetime`"}},{`"source`":{`"type`":`"Int32`",`"name`":`"EtlBatchId`"},`"sink`":{`"name`":`"EtlBatchId`",`"physicalType`":`"int`"}},{`"source`":{`"type`":`"String`",`"name`":`"CurrentRowInd`"},`"sink`":{`"name`":`"CurrentRowInd`",`"physicalType`":`"String`"}}]}" | Out-File -FilePath "c:\temp\$($__entityname)SqlFields.txt"