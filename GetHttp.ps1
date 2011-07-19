
function global:Get-Http
{
    param ($url, [switch]$pipe)

    #$assembly = [Reflection.Assembly]::LoadWithPartialName("System.Web.Extensions")
    $client = New-Object System.Net.WebClient
    $result = $client.DownloadString($url)

    if (!$pipe) {
        write-output $result
    }
    else {
        $lines = $result.Split([System.Environment]::NewLine)

        for ($i=0;$i -lt $lines.Length;$i++) {
            write-output $lines[$i]
        }
    }
}