<#
.EXAMPLE
PS ~> get http://digg.com | parse-html "//h3" | Get-TextFromHtml | Concat-Text
#>
function global:Get-TextFromHtml
{
    begin
    {
        $web = [system.reflection.assembly]::LoadWithPartialName("System.Web")
    }
    process 
    {
        if ($_.Name -ne "script" -and $_.Name -ne "style")
        {
            $after = $false
            
            if ($_.Name -eq "br" -or $_.Name -eq "p")
            {
                write-output "[br]"
            }
            
            if ($_.Name -eq "h1" -or $_.Name -eq "h2" -or $_.Name -eq "h3" -or $_.Name -eq "h4" -or $_.Name -eq "h5" -or $_.Name -eq "h6")
            {
                write-output "[br]"
                $after = $true
            }
            
            if ($_.Name -eq "#text")
            {
                $val = [System.Web.HttpUtility]::HtmlDecode($_.innerhtml)
                write-output $val
            }
            
            if ($_.HasChildNodes)
            {
                $_.ChildNodes | Get-TextFromHtml
            }
            
            if ($after)
            {
                write-output "[br]"
            }
        }
    }
}

function global:Concat-Text
{
    begin
    {
        $text = New-Object system.text.stringbuilder
    }
    process
    {
        $v = $text.Append($_)
    }
    end
    {
        $val = $text.ToString() -replace "\s\s+"," "
        $val = $val -replace "\[br\]",[System.Environment]::NewLine

        Write-Big $val
    }
}