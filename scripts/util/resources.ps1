. "$PSScriptRoot\backups.ps1"

Function Install-Resource-File()
{
    param([string]$resourcePath, [string]$installPath, [string]$name, [string]$ext = "")
    Backup-File -Path $installPath -Name $name -Ext $ext
    Copy-Item -Path "$PSScriptRoot\..\..\resources\$resourcePath" -Destination $installPath
}
