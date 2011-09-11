
function global:Get-Http
{
    param ($url, [switch]$pipe)

    if (!$url.StartsWith("http")) {
        $url = "http://$url"
    }

    #$assembly = [Reflection.Assembly]::LoadWithPartialName("System.Web.Extensions")
    $client = New-Object System.Net.WebClient

    $os = [System.Environment]::OSVersion
    $platform = $os.Platform
    $major = $os.Version.Major
    $minor = $os.Version.Minor
    $useragent = "PowerShellBrowser/0.1 ($platform;v$major.$minor)"
    $client.Headers.Add("user-agent", $useragent)

    $result = $client.DownloadString($url)
    
    $previousEncoding = $OutputEncoding
    $OutputEncoding = [Console]::OutputEncoding

    if (!$pipe) {
        write-output $result
    }
    else {
        $lines = $result.Split([System.Environment]::NewLine)

        for ($i=0;$i -lt $lines.Length;$i++) {
            write-output $lines[$i]
        }
    }

    $OutputEncoding = $previousEncoding
}