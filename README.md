# PSScripts

# PSScripts

### Description:
A collection of simple PowerShell scripts that I use in my role as a system administrator. These scripts are designed to help with everyday tasks, such as managing Active Directory users and network resources. This repository aims to provide useful, time-saving tools for sysadmins working in similar environments.

### Features:
- **Active Directory Integration:** Scripts utilize the Active Directory Module to interact with user profiles and attributes.
- **Network Drive Management:** Identify and manage users with specific network drives mapped to their profiles.
- **Data Migration Assistance:** Facilitate the migration of user data from network drives to OneDrive or other cloud storage solutions.

### Prerequisites:
- PowerShell installed on your system.
- Active Directory Module for Windows PowerShell.
- Appropriate permissions to query Active Directory user information.

### Usage:
1. **Clone the repository:**
    ```bash
    git clone https://github.com/yourusername/PSScripts.git
    cd PSScripts
    ```

2. **Run PowerShell with Administrator Privileges:**
   - Open PowerShell as an administrator to ensure you have the necessary permissions to execute scripts that interact with Active Directory.

3. **Load the Active Directory Module:**
    ```powershell
    Import-Module ActiveDirectory
    ```

4. **Execute the Script:**
   - This example script checks which users have a Z: drive mapped to their profile.
    ```powershell
    # need Active Directory Module
    $users = Get-ADUser -Filter * -Properties HomeDirectory

    foreach ($user in $users) {
        if ($user.HomeDirectory -like '*Z*') {
            Write-Host "User $($user.samaccountname) has a Z: Drive"
        }
    }
    ```

### Example Scenario:
This script was used to find out how many users had a network drive (Z: Drive) attached to their profile. The information was then used to help migrate the data from these network drives to OneDrive, and remove the network drive mapping from the user profiles. This approach ensured that all user data was properly transitioned to the cloud, improving accessibility and data security.

### Notes:
- Ensure that your user account has sufficient privileges to query user attributes in Active Directory.
- Always test scripts in a controlled environment before deploying them in production to avoid unintended changes.
