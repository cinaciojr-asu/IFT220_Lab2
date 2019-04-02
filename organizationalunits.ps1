# brutforce script to make some organizational units

# you need to change "DC=ad,DC=sparky-tech,DC=com" to match your domain and update the ST initials to match or remove them

$path="DC=AD,DC=cinacio,DC=lan"
$ou="CI"
Write-Host -ForegroundColor yellow "Creating OUs"
if(Get-ADOrganizationalUnit -Filter "distinguishedName -eq 'OU=$ou Computers,$path'") {
  Write-host "OU=$ou Computers,$path already exists."
} else {
  New-ADOrganizationalUnit -Name "$ou Computers" -Path $path -Description "$ou Computers" -ProtectedFromAccidentalDeletion $False
}
if(Get-ADOrganizationalUnit -Filter "distinguishedName -eq 'OU=Workstations,OU=$ou Computers,$path'") {
  Write-host "OU=Workstations,OU=$ou Computers,$path already exists."
} else {
  New-ADOrganizationalUnit -Name Workstations -Path "OU=$ou Computers,$path" -ProtectedFromAccidentalDeletion $False
}
if(Get-ADOrganizationalUnit -Filter "distinguishedName -eq 'OU=President,OU=Workstations,OU=$ou Computers,$path'") {
  Write-host "OU=President,OU=Workstations,OU=$ou Computers,$path already exists."
} else {
  New-ADOrganizationalUnit -Name President -Path "OU=Workstations,OU=$ou Computers,$path" -ProtectedFromAccidentalDeletion $False
}
if(Get-ADOrganizationalUnit -Filter "distinguishedName -eq 'OU=Finance,OU=Workstations,OU=$ou Computers,$path'") {
  Write-host "OU=Finance,OU=Workstations,OU=$ou Computers,$path already exists."
} else {
  New-ADOrganizationalUnit -Name Finance -Path "OU=Workstations,OU=$ou Computers,$path" -ProtectedFromAccidentalDeletion $False
}
if(Get-ADOrganizationalUnit -Filter "distinguishedName -eq 'OU=HR,OU=Workstations,OU=$ou Computers,$path'") {
  Write-host "OU=HR,OU=Workstations,OU=$ou Computers,$path already exists."
} else {
  New-ADOrganizationalUnit -Name HR -Path "OU=Workstations,OU=$ou Computers,$path" -ProtectedFromAccidentalDeletion $False
}
if(Get-ADOrganizationalUnit -Filter "distinguishedName -eq 'OU=Sales,OU=Workstations,OU=$ou Computers,$path'") {
  Write-host "OU=Sales,OU=Workstations,OU=$ou Computers,$path already exists."
} else {
  New-ADOrganizationalUnit -Name Sales -Path "OU=Workstations,OU=$ou Computers,$path" -ProtectedFromAccidentalDeletion $False
}
if(Get-ADOrganizationalUnit -Filter "distinguishedName -eq 'OU=Legal,OU=Workstations,OU=$ou Computers,$path'") {
  Write-host "OU=Legal,OU=Workstations,OU=$ou Computers,$path already exists."
} else {
  New-ADOrganizationalUnit -Name Legal -Path "OU=Workstations,OU=$ou Computers,$path" -ProtectedFromAccidentalDeletion $False
}
if(Get-ADOrganizationalUnit -Filter "distinguishedName -eq 'OU=IT,OU=Workstations,OU=$ou Computers,$path'") {
  Write-host "OU=IT,OU=Workstations,OU=$ou Computers,$path already exists."
} else {
  New-ADOrganizationalUnit -Name IT -Path "OU=Workstations,OU=$ou Computers,$path" -ProtectedFromAccidentalDeletion $False
}
if(Get-ADOrganizationalUnit -Filter "distinguishedName -eq 'OU=Servers,OU=$ou Computers,$path'") {
  Write-host "OU=Servers,OU=$ou Computers,$path already exists."
} else {
 New-ADOrganizationalUnit -Name Servers -Path "OU=$ou Computers,$path" -ProtectedFromAccidentalDeletion $False
}
if(Get-ADOrganizationalUnit -Filter "distinguishedName -eq 'OU=Hyper-V,OU=Servers,OU=$ou Computers,$path'") {
  Write-host "OU=Hyper-V,OU=Servers,OU=$ou Computers,$path already exists."
} else {
  New-ADOrganizationalUnit -Name Hyper-V -Path "OU=Servers,OU=$ou Computers,$path" -ProtectedFromAccidentalDeletion $False
}
if(Get-ADOrganizationalUnit -Filter "distinguishedName -eq 'OU=Exchange,OU=Servers,OU=$ou Computers,$path'") {
  Write-host "OU=Exchange,OU=Servers,OU=$ou Computers,$path already exists."
} else {
  New-ADOrganizationalUnit -Name Exchange -Path "OU=Servers,OU=$ou Computers,$path" -ProtectedFromAccidentalDeletion $False
}
if(Get-ADOrganizationalUnit -Filter "distinguishedName -eq 'OU=$($ou)_Groups,$path'") {
  Write-host "OU=$($ou)_Groups,$path already exists."
} else {
  New-ADOrganizationalUnit -Name $ou"_Groups" -Path $path -Description "High Level Security Groups" -ProtectedFromAccidentalDeletion $False
}
if(Get-ADOrganizationalUnit -Filter "distinguishedName -eq 'OU=$($ou)_Privileged_Accounts,$path'") {
  Write-host "OU=$($ou)_Privileged_Accounts,$path already exists."
} else {
  New-ADOrganizationalUnit -Name $ou"_Privileged_Accounts" -Path $path -Description "Privileged Accounts" -ProtectedFromAccidentalDeletion $False
}
if(Get-ADOrganizationalUnit -Filter "distinguishedName -eq 'OU=$($ou)_Users,$path'") {
  Write-host "OU=$($ou)_Users,$path already exists."
} else {
  New-ADOrganizationalUnit -Name $ou"_Users" -Path $path -Description "Non-Privileged Accounts" -ProtectedFromAccidentalDeletion $False
}
Write-Host -ForegroundColor yellow "Done creating OUs"
Write-Host -ForegroundColor yellow ""

Write-Host -ForegroundColor yellow "Creating groups based on department"
New-ADGroup -GroupCategory Security -GroupScope Global -Name President -Path "OU=$($ou)_Groups,$path"
New-ADGroup -GroupCategory Security -GroupScope Global -Name Finance -Path "OU=$($ou)_Groups,$path"
New-ADGroup -GroupCategory Security -GroupScope Global -Name HR -Path "OU=$($ou)_Groups,$path"
New-ADGroup -GroupCategory Security -GroupScope Global -Name Sales -Path "OU=$($ou)_Groups,$path"
New-ADGroup -GroupCategory Security -GroupScope Global -Name Legal -Path "OU=$($ou)_Groups,$path"
New-ADGroup -GroupCategory Security -GroupScope Global -Name IT -Path "OU=$($ou)_Groups,$path"
# Create a Leadership group for the President and VPs to access restricted a file share
New-ADGroup -GroupCategory Security -GroupScope Global -Name Leadership -Path "OU=$($ou)_Groups,$path"
Write-Host -ForegroundColor yellow "Done creating groups"
Write-Host -ForegroundColor yellow ""
