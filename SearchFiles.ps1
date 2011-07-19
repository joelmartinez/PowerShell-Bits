function global:Search-Files {
    param ($filter, $pattern, [switch]$recurse)
    if ($recurse) {
        get-childitem -recurse -include $filter | select-string $pattern
    } else {
        get-childitem $filter | select-string $pattern
    }
}