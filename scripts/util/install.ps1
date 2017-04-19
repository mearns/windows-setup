
Function Choco-Install()
{
  param([string]$package)
  choco install -y $package
  if ($LastExitCode -ne 0) {
    throw "Error occurred installing $name which cholocatey. Error code: $LastExitCode"
  }
}
