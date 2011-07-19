function global:Search-Web {
    param (
        [switch]$bing, 
        [switch]$goog,
        [Alias("q")]$query)

        $url = "http://bing.com/search?q="
        if ($goog) { $url = "http://google.com/#q=" }

	$query = [System.Uri]::EscapeDataString($query)
        start-process $url$query
}