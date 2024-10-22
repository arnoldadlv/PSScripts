# Get all users
$users = @(Get-MgUser -All)

# Initialize an array to store users without BitLocker recovery codes
$usersWithoutBitLocker = @()

foreach ($user in $users) {
    try {
        # Get devices associated with the user
        $devices = Get-MgUserManagedDevice -UserId $user.Id -ErrorAction Stop

        # Flag to check if BitLocker recovery key is found
        $hasBitLocker = $false

        foreach ($device in $devices) {
            # Get BitLocker recovery keys for the device
            $bitLockerKeys = Get-MgDeviceManagedDeviceRecoveryKey -ManagedDeviceId $device.Id -ErrorAction Stop

            if ($null -ne $bitLockerKeys) {
                $hasBitLocker = $true
                break
            }
        }

        # If no BitLocker recovery keys are found, add the user to the array
        if (-not $hasBitLocker) {
            $usersWithoutBitLocker += $user
        }
    }
    catch {
        # Silently handle 404 errors (no devices or BitLocker keys found)
        if ($_.Exception.StatusCode -eq 404) {
            # Log or silently continue
            $usersWithoutBitLocker += $user
        }
    }
}

# Display the list of users without BitLocker recovery codes
$usersWithoutBitLocker | Select-Object DisplayName, UserPrincipalName
