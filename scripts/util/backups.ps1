
Function Get-Backup-Dir() {
    "$PSScriptRoot\..\..\backups"
}

Function Get-Backup-Manifest-File() {
    "$(Get-Backup-Dir)\__manifest.txt"
}

Function Record-Change()
{
  param([string]$description, [string]$oldValue, [string]$newValue)
  Add-Content $(Get-Backup-Manifest-File) "$description. From [$oldValue], to [$newValue]"
}

Function Initialize-Backup()
{
  $backupDir = Get-Backup-Dir
  Write-Host "Backing up Files to: $backupDir"
  If ( -Not (Test-Path "$backupDir") )
  {
      New-Item -ItemType directory -Path "$backupDir"
  }

  $backupRecordFile = Get-Backup-Manifest-File
  Add-Content "$backupRecordFile" "Beginning Installation: $(Get-Date)`n"
}

Function Backup-Dir()
{
  param([string]$path, [string]$name)

  If (Test-Path $path) {
    $archive = New-TemporaryFile | Rename-Item -NewName { $_ -replace '$', '.zip' } -PassThru
    $archivePath = $archive.FullName
    Compress-Archive -Path $path -Destination $archivePath -Force
    $hash = (Get-FileHash -Path $archivePath -Algorithm SHA512).Hash
    $backupFile = "$(Get-Backup-Dir)\$name-$hash.zip";
    If (-Not (Test-Path $backupFile)) {
      Add-Content "$(Get-Backup-Manifest-File)" "Backing up directory $name from [$path] to [$backupFile]`n"
      Copy-Item -Path $archivePath -Destination $backupFile
    }
    $archive.Delete()
  }
}

Function Backup-File()
{
  param([string]$path, [string]$name, [string]$ext = "")

  If (Test-Path $path) {
    $hash = (Get-FileHash -Path "$path" -Algorithm SHA512).Hash
    $backupFile = "$(Get-Backup-Dir)\$name-$hash$ext";
    If (-Not (Test-Path $backupFile)) {
      Add-Content "$(Get-Backup-Manifest-File)" "Backing up $name from [$path] to [$backupFile]`n"
      Copy-Item -Path "$path" -Destination "$backupFile"
    }
  }
}
