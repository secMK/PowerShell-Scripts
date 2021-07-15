$RHOSTS = Get-Content -path C:\Temp\RHOSTS.txt

$RHOSTS | foreach { (Get-Service -Name spooler -computername $_) | Select-Object MachineName, Status, Name, DisplayName } | Export-Csv -Path C:\Temp\Get-Service_Servers.csv
