function global:Write-Big
{
    param([string]$url)
    $file = [System.IO.Path]::GetTempFileName()
    
    $_ | Out-File $file

    $oldEncoding = $OutputEncoding
    $OutputEncoding = [Console]::OutputEncoding

    Get-Content $file | Write-Host

    $OutputEncoding = $oldEncoding

    if (Test-Path $file) { Remove-Item $file}
}