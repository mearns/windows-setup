
function Run-Command-Or-Fail()
{
  param([string]$command)

  iex $command
  if ($LastExitCode -ne 0)
  {
    throw "Error running command; exit code was ${LastExitCode}: [$command]"
  }
}
