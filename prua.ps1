##############################################################################################
#
# Title: PRUA - Password Reset Unlock Account Tools v1.0
# Date Created : 06/28/2021
# Author : Matthew Kurniawan
# GitHub: https://github.com/secMK/PowerShell-Scripts
#
# This Powershell Script allows an Administratior or a Help Desk user to reset end user
# passwords or unlock accounts through the cli in Powershell + pull AD info/pass/acc info
###############################################################################################

Import-Module ActiveDirectory

#create function Show-Menu which creates a text based menu in the cli
function Show-Menu
{
    param (
        [string]$Title = 'PRUA TOOLKIT'
    )
    Clear-Host
    Write-Host "================ $Title ================"
    
    Write-Host "1: Press '1' Get-ADUser info"
    Write-Host "2: Press '2' Get-Password & Acount Properties"
    Write-Host "3: Press '3' Password Reset"
    Write-Host "4: Press '4' Unlock Account"
    Write-Host "Q: Press 'Q' to quit."
}
#call function - get user selection
Show-Menu
$selection = Read-Host -Prompt 'Select Option:'
switch ($selection)
 {
     '1'
     {
     $username = Read-Host -Prompt '1. Enter Username'
     Get-ADUser -Identity $username -Properties * | Fl CN,SamAccountName, SID,
     UserPrincipalName, whenCreated, Title, Department, Manager
     }
     '2'
     {
     $username = Read-Host -Prompt '2. Enter Username'
     Get-ADUser -Identity $username -Properties * | Select-Object -Property SamAccountName,
     "Displayname",@{Name="ExpiryDate";Expression={[datetime]::FromFileTime($_."msDS-UserPasswordExpiryTimeComputed")}},
     PasswordLastSet, PasswordNeverExpires, badPwdCount, badPassWordTime,
     BadLogonCount, LockedOut, AccountLockoutTime, AccountExpirationDate | Format-List
     }
     '3'
     {
     $username = Read-Host -Prompt '3. Enter Username'
     $NewPasswd = Read-Host "Enter a new user password" –AsSecureString
     Set-ADAccountPassword -Identity $username -NewPassword $NewPasswd -Reset -PassThru
     'Password reset complete, please confirm with end user'
     }
     '4'
     {
     $username = Read-Host -Prompt '4.Enter Username'
     Unlock-ADAccount –Identity $username -PassThru
         'AD Account Unlocked, please confirm with end user'
     } 
     'q'
     {
     '“If you quit on the process, you are quitting on the result.”'
     return
     }
 }


