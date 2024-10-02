###Create TAP for new user laptop setup:

$user = Read-Host -Prompt "Type in the UPN of the user you wish to create a TAP for: "
$params = @{
    IsUsableOnce    = $false
    StartDateTime   = (Get-Date)
    EndDateTime     = (Get-Date).AddHours(1)  # Valid for 1 hour
}

$tap = New-MgUserAuthenticationTemporaryAccessPassMethod -UserId $user -BodyParameter $params

# Display the TAP value
$tap.TemporaryAccessPass
 