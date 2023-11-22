# need Active Directory Module

$users = Get-ADUser -Filter * -Properties HomeDirectory

foreach ($user in $users) {
    if ($user.HomeDirectory -like '*Z*') {
    Write-Host "User $($user.samaccountname) has a Z: Drive"
   }
}