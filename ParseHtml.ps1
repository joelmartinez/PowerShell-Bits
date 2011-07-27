<#

.SYNOPSIS

Lets you execute XPath queries against HTML

.DESCRIPTION

Uses the HtmlAgilityPack assembly to parse HTML in the pipeline and executes an XPath query against the parsed source.

.PARAMETER xpath
The xpath query to use

.EXAMPLE

PS ~> get-http "http://google.com" | Parse-Html "//a" | select OuterHtml, @{Name="href";Expression={$_.Attributes["href"].Value}}

.EXAMPLE

You can also pipe html text directly from existing files.


PS ~> gc .\goog.html | Parse-Html "//a" | select InnerHtml, @{Name="href";Expression={$_.Attributes["href"].Value}}

.EXAMPLE

Rudimentary 'browsers' can be created simply by parsing the HTML for the site in question and displaying the relevant content



PS ~> $web = [system.reflection.assembly]::LoadWithPartialName("System.Web")

PS ~> get-http "http://digg.com" | Parse-Html "//h3/a[text()]" | select @{Name="Title";Expression={[System.Web.HttpUtility]::HtmlDecode($_.innerhtml)}}, @{Name="Url";Expression={$_.Attributes["href"].Value}}

.EXAMPLE

This will retrieve a page of results from Bing, and output the Title, Url, and Description as a list of PSObjects



PS ~> get-http http://bing.com/search?q=finance+industry | parse-html "//li[@class='sa_wr']/div" | select @{Name="Title";Expression={$_.SelectNodes("div/h3/a")[0].InnerHtml}},  @{Name="Url";Expression={$_.SelectNodes("div/h3/a")[0].Attributes["href"].Value}}, @{Name="Description";Expression={$_.SelectNodes("p")[0].InnerHtml}}

#>


function global:Parse-Html

{

    param ($xpath)

    process

    {
    
    $location = Resolve-Path ~/Documents/WindowsPowerShell
        $location = "$location\dependencies\HtmlAgilityPack.dll"

        $assembly = [system.reflection.assembly]::LoadFile($location)



        $html = new-object HtmlAgilityPack.HtmlDocument

        $html.LoadHtml("$_")

        $html.DocumentNode.SelectNodes($xpath) | foreach-object { write-output $_ }

    }

}