
. "$PSScriptRoot\backups.ps1"

Function Set-Env-Var()
{
  param([string]$name, [string]$value, [string]$envType = "User")

  If (Test-Path "Env:$name")
  {
    $currentValue = Get-Item "Env:$name"
    Record-Change -Description "Changing Environment Variable `"$name`"" -OldValue $currentValue -NewValue $value
  }
  Else {
    Record-Change -Description "Creating Environment Variable `"$name`"" -OldValue "<not-set>" -NewValue $value
  }

  [Environment]::SetEnvironmentVariable($name, $value, $envType)
}

Function Ensure-At-Start-Of-Path()
{
  param([string]$element, [string]$envType = "User")

  $pathComponents = (,$element) + ([Environment]::GetEnvironmentVariable("PATH", $envType).Split(';') -ne $element)
  $newPath = $pathComponents -join ";"
  Set-Env-Var -Name "PATH" -Value $newPath -EnvType $envType
}

Function Ensure-On-Path()
{
  param([string]$element, [string]$envType = "User")

  $pathComponents = [Environment]::GetEnvironmentVariable("PATH", $envType).Split(';')
  If (-Not $pathComponents.Contains($element)) {
    $newPathComponents = $pathComponents + (,$element)
    $newPath = $newPathComponents -join ";"
    Set-Env-Var -Name "PATH" -Value $newPath -EnvType $envType
  }
}
