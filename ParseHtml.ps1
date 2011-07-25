<#
.SYNOPSIS
Lets you execute XPath queries against 
.DESCRIPTION
Uses the HtmlAgilityPack assembly to parse HTML in the pipeline and executes an XPath query against the parsed source.
.PARAMETER xpath
The xpath query to use
.EXAMPLE
PS ~> get-http "http://google.com" | Parse-Html "//a" | select OuterHtml, @{Name="href";Expression={$_.Attributes["href"].Value}}
#>
function global:Parse-Html
{
    param ($xpath)
    process 
    {    
        $location = get-location
        $location = "$location\dependencies\HtmlAgilityPack.dll"
        $assembly = [system.reflection.assembly]::LoadFile($location)
    
        $html = new-object HtmlAgilityPack.HtmlDocument
        $html.LoadHtml("$_")
        $html.DocumentNode.SelectNodes($xpath) | foreach-object { write-output $_ }
    }
}