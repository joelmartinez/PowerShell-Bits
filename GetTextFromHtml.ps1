function global:Get-TextFromHtml
{
    begin
    {
        $web = [system.reflection.assembly]::LoadWithPartialName("System.Web")
    }
    process 
    {
        if ($_.Name -eq "#text")
        {
            $val = [System.Web.HttpUtility]::HtmlDecode($_.innerhtml)
            write-output $val
        }
        
        if ($_.HasChildNodes)
        {
            $_.ChildNodes | Get-TextFromHtml
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
        write-host "   "
        write-host $val

    }
}