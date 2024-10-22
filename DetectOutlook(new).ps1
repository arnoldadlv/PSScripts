#Get-AppxPackage -AllUsers | Where-Object{$_.Name -like "*Outlook*"}

if (Get-AppxPackage -AllUsers | Where-Object{$_.Name -like "*Outlook*"}){
    exit 0
} else {
    exit 1
}