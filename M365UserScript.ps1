Connect-MGGraph -Environment USGov -TenantId '918db723-3d22-445b-8227-2c1880fb6637'
#Get-MgSubscribedSku -All | Where {$_.SkuPartNumber -eq 'SPE_E3_USGOV_GCCHIGH'}
#Get-MgUser -All

$FirstName = Read-Host "Enter the new users First Name"
$LastName = Read-Host "Enter the new users Last Name"
$LastNameNoSpaces = $LastName -replace '\s',''
$DisplayName = "$FirstName $LastName"
$domain = "ultimateammunition.com"
$Userprincipalname = ($FirstName.Substring(0,1) + $LastNameNoSpaces + "@" + $domain).toLower()

$JobTitle = Read-Host "What is the new users job title: "
$CompanyName = Read-Host "What is the new users Company Name: "
$Department = Read-Host "What department is the new user in? "
$OfficeLocation = Read-Host "What is the office location? "
$ManagerUPN = Read-Host "Who is their manager? "
$Manager = Get-MgUser -UserId $ManagerUPN
$UsageLocation = "US"

$ENTERPRISEPACK_USGOV_GCCHIGH = Get-MgSubscribedSku -All | Where-Object SkuPartNumber -eq "ENTERPRISEPACK_USGOV_GCCHIGH"
$EMS_USGOV_GCCHIGH = Get-MgSubscribedSku -All | Where-Object SkuPartNumber -eq "EMS_USGOV_GCCHIGH"
$ATP_ENTERPRISE_USGOV_GCCHIGH = Get-MgSubscribedSku -All | Where-Object SkuPartNumber -eq "ATP_ENTERPRISE_USGOV_GCCHIGH"



$licenseSKUIds = @(
    @{SkuId = $ENTERPRISEPACK_USGOV_GCCHIGH.SkuId},
    @{SkuId = $EMS_USGOV_GCCHIGH.SkuId},
    @{SkuId = $ATP_ENTERPRISE_USGOV_GCCHIGH.SkuId}
)

foreach ($skuid in $licenseSKUIds) {
    write-host $skuid 
}


<#foreach ($license in $licenseSKUIds) {
    $AssignedLicenses += [Microsoft.Graph.PowerShell.Models.MicrosoftGraphAssignedLicense]@{ SkuId = $SkuId }
}
Write-Host "The new users display name: $DisplayName"
Write-Host "The new users principal name $Userprincipalname"
#>

# Password Profile (you can modify this to generate a random password or use a standard one)
$PasswordProfile = @{
    Password = 'yjDn?%d!4)UR'  # Replace this with a generated or user-defined password
    ForceChangePasswordNextSignIn = $true
}

$mailNickName = $Userprincipalname.Split("@")[0]
New-MgUser 
  -DisplayName $DisplayName `
   -UserPrincipalName $Userprincipalname `
      -UsageLocation $UsageLocation `
        -Department $Department `
         -OfficeLocation $OfficeLocation `
          -CompanyName $CompanyName `
           -JobTitle $JobTitle `
           -AccountEnabled $true `
           -PasswordProfile $PasswordProfile `
           -MailNickname $mailNickName 
set-mguser -UserId $Userprincipalname -UsageLocation $UsageLocation
#Set-MgUserLicense -UserId $Userprincipalname -AddLicenses $AssignedLicenses

 