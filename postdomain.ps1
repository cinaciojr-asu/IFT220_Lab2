# Run this after the machine reboots and check the output for errors

# Check the that the DNS server IP address on the NIC is set to our non-loopback IP and set it if needed
$nicname = Get-NetAdapter -name "Ethernet" | select -ExpandProperty "name"
$ipaddress = Get-NetIPAddress -InterfaceAlias $nicname -AddressFamily IPv4 | select -ExpandProperty "IPAddress"
if ((Get-DnsClientServerAddress -InterfaceAlias $nicname -AddressFamily IPv4 | select -ExpandProperty "ServerAddresses") -ne $ipaddress) 
{
Set-DnsClientServerAddress -InterfaceAlias $nicname -ServerAddresses ($ipaddress) -Validate
}

dcdiag
Get-Service adws,kdc,netlogon,dns
Get-smbshare

Write-Host -ForegroundColor yellow "Check for errors."
