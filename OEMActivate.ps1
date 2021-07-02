#This script fetches the OEM license from motherboard and activates Windows
$Productkey = (Get-WmiObject -Class SoftwareLicensingService).OA3xOriginalProductkey
cscript /b C:\Windows\System32\slmgr.vbs -ipk $Productkey
cscript /b C:\Windows\System32\slmgr.vbs -ato
