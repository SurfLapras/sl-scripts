# Wake on LAN
<#
    「使い方」
    引数にMACアドレス（例.00-00-00-00-00-00）を渡してください。
#>

Param($macAddress)

# ポート（7, 9, 2304など）
$port = 2304

$header = [byte[]](@(0xFF)*6)
$macAddress = [System.Net.NetworkInformation.PhysicalAddress]::Parse($macAddress).GetAddressBytes()
$magicPacket = $header + $macAddress * 16

$client = New-Object System.Net.Sockets.UdpClient
$target=[System.Net.IPAddress]::Broadcast
$client.Connect($target, $port)
$client.Send($magicPacket, $magicPacket.Length) | Out-Null
$client.Close()