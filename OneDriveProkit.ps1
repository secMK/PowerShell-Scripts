###########################################################################################################
#
# Title: OneDrive Prokit
# Date Created : 07/02/2021
# Author : Matthew Kurniawan
# GitHub: https://github.com/secMK/PowerShell-Scripts
# This Powershell Script allows Sharepoint Administrators to;
#
# 1.Provision OneDrive Accounts from Users.txt
# Users.txt must contain list of UserProvisionalNames and be placed in "c:\temp\Users.txt"
# path can be changed if desired
#
# 2. Get-All User OneDrive URLs in your organization as OneDriveSites.log .txt and outputs it to the Desktop
# Used to verify successful OneDrive account provisioning
##############################################################################################################


Connect-SPOService -Url https://contoso-admin.sharepoint.com -credential spadmin@contoso.com
function Show-Menu
{
    param (
        [string]$Title = 'OneDrive Prokit'
    )
    Clear-Host
    Write-Host "================ $Title ================"
    
    Write-Host "1: Press '1' Provision OneDrive Accounts from Users.txt"
    Write-Host "2: Press '2' Get-All User OneDrive URLs as OneDriveSites.log"
    Write-Host "Q: Press 'Q' to quit."
}
Show-Menu
$selection = Read-Host -Prompt 'Select Option:'
switch ($selection)
 {
     '1'
     {
     $users = Get-Content -path "c:\temp\Users.txt"
     Request-SPOPersonalSite -UserEmails $users
     }
     '2'
     {
     $LogFile = [Environment]::GetFolderPath("Desktop") + "\OneDriveSites.log"
     Connect-SPOService -Url https://defencehealthlimited-admin.sharepoint.com
     Get-SPOSite -IncludePersonalSite $true -Limit all -Filter "Url -like '-my.sharepoint.com/personal/'" | Select -ExpandProperty Url | Out-File $LogFile -Force
     Write-Host "Done! File saved as $($LogFile)."
     }
     'q'
     {
     '“If you quit on the process, you are quitting on the result.”'
     return
     }
 }
