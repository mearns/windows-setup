
Function Choco-Install()
{
  param([string]$package)
  choco install -y $package
  if ($LastExitCode -ne 0) {
    throw "Error occurred installing $package which cholocatey. Error code: $LastExitCode"
  }
}

Function Apm-Install()
{
    param([string]$package)
    $proc = Start-Process "$Env:LOCALAPPDATA\atom\bin\apm.cmd" -ArgumentList ("install", $package) -Wait -NoNewWindow -PassThru
    If ($proc.ExitCode -ne 0)
    {
        $exitCode = $proc.ExitCode
        throw "Installation of atom package '$package' failed with exit code $exitCode."
    }
}

Function Apm-Uninstall()
{
    param([string]$package)
    $proc = Start-Process "$Env:LOCALAPPDATA\atom\bin\apm.cmd" -ArgumentList ("uninstall", $package) -Wait -NoNewWindow -PassThru
    If (($proc.ExitCode -ne 0) -and ($proc.ExitCode -ne 1))
    {
        $exitCode = $proc.ExitCode
        throw "Uninstallation of atom package '$package' failed with exit code $exitCode."
    }
}
