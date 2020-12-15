param($username,
    $password,
    $orgName,
    $region,    
    $orgUrl,
    $status,
    $name,
    $newname,
    $businesshoursid
)

<###################################################################################################

This set Rule Set to 'Active'
The package usually contains data (i.e Entities and other CRM components) and solution files

Required Parameters 
    
    username      - Organization username
    password      - Organization password
    orgName       - Organization Name where to import the data and solutions
    region        - Which region is your organization belongs to
    orgUrl        - This is the URL of an Organization to deploy to
    status        - Draft or Active status of the SLA 
    name          - Name of the SLA to act upon
    newname       - New name of the SLA
    calendarname  - Name of the calendar
####################################################################################################> 

$username = "SVC-Covid19@ct.gov"
$password = "KWwe3&s@ld#52[95ljeidwso"
$orgName = "org1f8cfc57"
$region = "GCC"
$orgUrl  = "https://covid19dev.crm9.dynamics.com/"

Write-Verbose "===================================================================="
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser -Force

#Credentials
$secstr = New-Object -TypeName System.Security.SecureString
$password.ToCharArray() | ForEach-Object {$secstr.AppendChar($_)}
#No PROMPT for credential
$cred = new-object -typename System.Management.Automation.PSCredential -argumentlist $username, $secstr

#this is required to establish connection in order for Get-CrmConnection to work
$conn = Connect-CrmOnline -Credential $cred -ServerUrl $orgUrl  -ForceDiscovery 

$__conn = Get-CrmConnection -DeploymentRegion $region –OnlineType Office365 –OrganizationName $orgName  -Credential $cred -LogWriteDirectory $logLocation -Verbose 
