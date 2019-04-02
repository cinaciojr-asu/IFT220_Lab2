# Builds a new DC in a new Forest
# Assumption: new machine uses DHCP

# Change from DHCP to static IP using the same IP
# Get the name of the network adapter
$nicname = Get-NetAdapter  | select -ExpandProperty "Ethernet"
Write-Host -ForegroundColor yellow $nicname 

# Get current IP Address, Prefix Length (subnet mask), and gateway
$ipaddress = Get-NetIPAddress -InterfaceAlias $nicname -AddressFamily IPv4 | select -ExpandProperty "IPAddress"
$prefixlength = Get-NetIPAddress -InterfaceAlias $nicname -AddressFamily IPv4 | select -ExpandProperty "PrefixLength"
$gateway = Get-NetIPConfiguration -InterfaceAlias $nicname | select -ExpandProperty "IPv4DefaultGateway" | select -ExpandProperty "NextHop"
Write-Host -ForegroundColor yellow $ipaddress/$prefixlength 
Write-Host -ForegroundColor yellow $gateway 

# Set the current IP address as static
Remove-NetIPAddress -InterfaceAlias $nicname -AddressFamily IPv4 -Confirm:$false
#Remove-NetRoute -InterfaceAlias $nicname -AddressFamily IPv4 -Confirm:$false
New-NetIPAddress -InterfaceAlias $nicname -IPAddress $ipaddress -AddressFamily IPv4 -PrefixLength $prefixlength -DefaultGateway $gateway

# Set the DNS address to ourselves
Set-DnsClientServerAddress -InterfaceAlias $nicname -ServerAddresses ($ipaddress)
Get-DnsClientServerAddress -InterfaceAlias $nicname -AddressFamily IPv4 | select -ExpandProperty "ServerAddresses"


# Make sure the timezone is set correctly
Get-TimeZone | select -ExpandProperty "DisplayName"
Write-Host -ForegroundColor yellow "Is that the correct timezone?"
$Readhost = Read-Host -Prompt ("y | n ")
    Switch ($ReadHost) 
     { 
       Y {Write-Host "Okay, moving on."}
       N {Write-Host -ForegroundColor yellow "Use the GUI to set the timezone. Press Enter when the timezone is set."; Read-Host}
       Default {Write-Host -ForegroundColor yellow "Use the GUI to set the timezone. Press Enter when the timezone is set."; Read-Host}
     }

# Install the AD Services
Do {
Write-Host -ForegroundColor yellow "What's the domain name going to be? It should be"
Write-Host -ForegroundColor yellow "ad.<your ASUrite ID>.lan, for example"
Write-Host -ForegroundColor yellow "ad.4sparky.lan"
$domainname = Read-Host "ad.<your ASUrite ID >.lan" 
} until ($domainname.StartsWith("ad."))

Write-Host -ForegroundColor Red "After you supply the SafeModeAdministratorPassword the machine will reboot on its own."

Install-WindowsFeature AD-Domain-Services -IncludeManagementTools | Out-Null
Install-ADDSForest -DomainName $domainname

# the machine will now reboot
