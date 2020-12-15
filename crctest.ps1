##[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12
##$Cred = Get-Credential
##$CRMOrgs = Get-CrmOrganizations -Credential $Cred -DeploymentRegion GCC –OnlineType Office365


$conntgt = Connect-CrmOnlineDiscovery -InteractiveMode

$__cr = Get-Content -Path C:\Users\contact\Documents\Sprint10\CRTest.txt

$__max = $__cr.Count;
##$__max = 2
for ($e=0; $e -lt $__max; $e++) {
  
  $e

  $__ht = @{}

  $__rec = Get-CrmRecord -conn $conntgt -EntityLogicalName ct_communityresources -Id $__cr[$e] -Fields *

  $__contact = Get-CrmRecord -conn $conntgt -EntityLogicalName contact -Id $__rec.ct_contactid_Property.Value.Id -Fields * -IncludeNullValue

   $__ht.Add("ct_assignedtocrc", $true)

   if ($__rec.ct_iapdocumentation -ne $null) {$__ht.Add("ct_crcbriefnotes", $__rec.ct_iapdocumentation) }

   if ($__rec.ct_additionalnotes -ne $null) {$__ht.Add("ct_crcadditionalnotes", $__rec.ct_additionalnotes) }

   if ($__rec.ct_beginfollowup) {
      $__optionset = New-CrmOptionSetValue -Value  206450000
      $__ht.Add("ct_crcbeginfollowup", $__optionset)
   } else {
      $__optionset = New-CrmOptionSetValue -Value  206450001
      $__ht.Add("ct_crcbeginfollowup", $__optionset)
   }



   if ($__rec.ct_followupstatus -ne $null) {
      $__optionset = New-CrmOptionSetValue -Value  $__rec.ct_followupstatus_Property.Value.Value
      $__ht.Add("ct_crcfollowupstatus", $__optionset)
   }

   if ($__rec.createdon -ne $null) {
      $__contact.ct_crcreferraldate = $__rec.createdon
      $__ht.Add("ct_crcreferraldate", [datetime]$__rec.createdon)
   }

   if ($__rec.ct_urgency -ne $null) {
      $__optionset = New-CrmOptionSetValue -Value  $__rec.ct_urgency_Property.Value.Value
      $__ht.Add("ct_crcurgency", $__optionset)
   }

   if ($__rec.ct_assessment_food -ne $null) {$__ht.Add("ct_crcneedsassessmentfood", $__rec.ct_assessment_food) }
   if ($__rec.ct_plan_food -ne $null) {$__ht.Add("ct_crciapfood", $__rec.ct_plan_food)}
   if ($__rec.ct_ct_intervention_food -ne $null) {$__ht.Add("ct_crcinterventionfood", $__rec.ct_ct_intervention_food)}
   if ($__rec.ct_assessment_health -ne $null) {$__ht.Add("ct_crcneedsassessmenthealth", $__rec.ct_assessment_health)}
   if ($__rec.ct_plan_health -ne $null) {$__ht.Add("ct_crciaphealth", $__rec.ct_plan_health)}
   if ($__rec.ct_intervention_health -ne $null) {$__ht.Add("ct_crcinterventionhealth", $__rec.ct_intervention_health)}
   if ($__rec.ct_assessment_house -ne $null) {$__ht.Add("ct_crcneedsassessmenthousing", $__rec.ct_assessment_house)}
   if ($__rec.ct_plan_house -ne $null) {$__ht.Add("ct_crciaphousing", $__rec.ct_plan_house)}
   if ($__rec.ct_intervention_house -ne $null) {$__ht.Add("ct_crcinterventionhealth", $__rec.ct_intervention_house)}
   if ($__rec.ct_assessment_other -ne $null) {$__ht.Add("ct_crcneedsassessmentincome", $__rec.ct_assessment_other)}
   if ($__rec.ct_plan_income -ne $null) {$__ht.Add("ct_crciapincome", $__rec.ct_plan_income)}
   if ($__rec.ct_intervention_income -ne $null) {$__ht.Add("ct_crcinterventionincome", $__rec.ct_intervention_income)}
   if ($__rec.ct_assessment_other -ne $null) {$__ht.Add("ct_crcneedsassessmentother", $__rec.ct_assessment_other)}
   if ($__rec.ct_plan_other -ne $null) {$__ht.Add("ct_crciapother", $__rec.ct_plan_other)}
   if ($__rec.ct_intervention_other -ne $null) {$__ht.Add("ct_crcinterventionother", $__rec.ct_intervention_other)}

   $__lookup = New-CrmEntityReference -EntityLogicalName systemuser -Id $__rec.ownerid_Property.Value.Id
   $__ht.Add("ct_assignedtocrcowner", $__lookup)

   if ($__rec.ct_demhsregionopt -ne $null) {
      $__optionset = New-CrmOptionSetValue -Value  $__rec.ct_demhsregionopt_Property.Value.Value
      $__ht.Add("ct_demhsregionopt", $__optionset)
   }

   Set-CrmRecord -conn $conntgt -EntityLogicalName contact -Id $__rec.ct_contactid_Property.Value.Id  -Fields $__ht
}