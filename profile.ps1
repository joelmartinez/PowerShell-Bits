. ~/documents/WindowsPowerShell/SearchFiles.ps1
. ~/documents/WindowsPowerShell/GetHttp.ps1
. ~/documents/WindowsPowerShell/SearchWeb.ps1
. ~/documents/WindowsPowerShell/ExecSql.ps1

function prompt
{
    $loc = $(get-location).ToString()
    $usr = ($env:userprofile).ToString()
    if ($loc.StartsWith($usr, $true,[System.Globalization.CultureInfo].CurrentCulture)) {
	$loc = "~"+$loc.SubString($usr.Length, $loc.Length - $usr.Length)
    }
    Write-Host ("PS " + $loc +">") -nonewline -foregroundcolor Yellow
    return " "
}
