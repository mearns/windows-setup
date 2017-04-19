
. "$PSScriptRoot\backups.ps1"

Function Get-Manual-Steps-File-Path()
{
  "$PSScriptRoot\..\..\NEXT-STEPS.md"
}

Function Init-Manual-Steps()
{
  $manualStepsFilePath = Get-Manual-Steps-File-Path
  Backup-File -Path $manualStepsFilePath -Name "NEXT-STEPS" -Ext ".md"
  If (Test-Path $manualStepsFilePath)
  {
    Remove-Item $manualStepsFilePath
  }
}

Function Add-Manual-Step()
{
  param([string]$Title, $lines)

  $manualStepsFilePath = Get-Manual-Steps-File-Path
  Add-Content -Path $manualStepsFilePath -Value "## $Title`n"
  Add-Content -Path $manualStepsFilePath -Value $lines
  Add-Content -Path $manualStepsFilePath -Value ""
}
