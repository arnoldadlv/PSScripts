###Remove TAP user:

$user = Read-Host -Prompt "Type in the UPN of the user you wish to remove a TAP for: "


$tap = Get-MgUserAuthenticationTemporaryAccessPassMethod -UserId $user

# Get TAP ID
$tapID = $tap.Id

Remove-MgUserAuthenticationTemporaryAccessPassMethod -UserId $user -TemporaryAccessPassAuthenticationMethodId $tapID