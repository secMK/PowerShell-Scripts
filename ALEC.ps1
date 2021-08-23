#create function Show-Menu which creates a text based menu in the cli
function Show-Menu
{
    param (
        [string]$Title = 'Application List Extractor & Comparator'   
    )
    param (
        [string]$Developer = 'Developer:secMK https://github.com/secMK/PowerShell-Scripts'   
    )
    Clear-Host
    Write-Host "================= $Title ======================================================================================="
    Write-Host "1: Press '1' Extract List of Installed Applications > Default Output Path: C:\Temp\"
    Write-Host "2: Press '2' Compare Extracted List InstalledPrograms-PS_A & InstalledPrograms-PS_B to  "
    Write-Host "3: Press '3' Print GNU Software License"
    Write-Host "Q: Press 'Q' to quit."
    Write-Host "================================================================================================================================================="
    Write-Host "READ ME FOR OPTION 2:"
    Write-Host "Entries with a side indicator pointing to the right (<=) mean that the software is installed on machine A but not on machine B"
    Write-Host "Entries with a side indicator pointing to the right (=>) mean that the software is installed on machine B but not on machine A"
    Write-Host "================= $Developer =============================================="
}
#call function - get user selection
Show-Menu
$selection = Read-Host -Prompt 'Select Option:'
switch ($selection)
 {
     '1'
     {
     Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName, DisplayVersion, Publisher, InstallDate | Format-Table –AutoSize > C:\Temp\Installed_Apps_A.txt
     }
     '2'
     {
     Compare-Object -ReferenceObject (Get-Content C:\Temp\Installed_Apps_A.txt) -DifferenceObject (Get-Content C:\Temp\Installed_Apps_B.txt)
     }
     '3'
     {
     'This program/script is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see https://www.gnu.org/licenses.
    
    Developed by Matthew Kurniawan for more information visit https://github.com/secMK/PowerShell-Scripts'
     return
     }
     'q'
     {
     '“If you quit on the process, you are quitting on the result.”'
     return
     }
 }
