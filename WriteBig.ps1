function global:Write-Big
{
    param([string]$val)
    $file = [System.IO.Path]::GetTempFileName()
    
    $val | Out-File $file

    $oldEncoding = $OutputEncoding
    $OutputEncoding = [Console]::OutputEncoding

    Get-Content $file | Write-Host

    $OutputEncoding = $oldEncoding

    if (Test-Path $file) { Remove-Item $file}
}