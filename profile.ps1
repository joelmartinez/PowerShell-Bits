. ~/documents/WindowsPowerShell/SearchFiles.ps1
. ~/documents/WindowsPowerShell/GetHttp.ps1
. ~/documents/WindowsPowerShell/SearchWeb.ps1
. ~/documents/WindowsPowerShell/ParseHtml.ps1
. ~/documents/WindowsPowerShell/ExecSql.ps1
. ~/documents/WindowsPowerShell/WriteBig.ps1
. ~/documents/WindowsPowerShell/GetTextFromHtml.ps1

function prompt
{
    $loc = $(get-location).ToString()
    $usr = ($env:userprofile).ToString()
    if ($loc.StartsWith($usr, $true,[System.Globalization.CultureInfo].CurrentCulture))     {
	$loc = "~"+$loc.SubString($usr.Length, $loc.Length - $usr.Length)
    }
    Write-Host ("PS " + $loc +">") -nonewline -foregroundcolor Yellow
    return " "
}

function elevate-process
{
    $file, [string]$arguments = $args;
    $psi = new-object System.Diagnostics.ProcessStartInfo $file;
    $psi.Arguments = $arguments;
    $psi.Verb = "runas";
    $psi.WorkingDirectory = get-location;
    $runningProcess = [System.Diagnostics.Process]::Start($psi);
}

$env:Path += ";c:\program files\sublime text 2";
$env:Path += ";C:\Windows\Microsoft.NET\Framework\v4.0.30319";

set-alias sudo elevate-process;
set-alias get get-http;
set-alias sublime sublime_text.exe;