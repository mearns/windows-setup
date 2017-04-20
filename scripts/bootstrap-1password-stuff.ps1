
. "$PSScriptRoot\util\manual-work.ps1"

$1passwordInstallationTimeoutSeconds = 5*60;

Try {
  $downloadPage = Invoke-WebRequest -Uri "https://1password.com/downloads/"
}
Catch {
  $error = $_.Exception.Message
  throw "Failed to download 1password download page: $error"
}

Try {
  $windowsIconElement =  $downloadPage.ParsedHtml.querySelector('div.downloads-platform > .windows-icon')
  $windowsDownloadSectionElement = $windowsIconElement.parentElement
  $downloadLinkElement = $windowsDownloadSectionElement.querySelector('a.download-blue.non-beta')
  $downloadUri = $downloadLinkElement.href;
}
Catch {
  $error = $_.Exception.Message
  throw "Failed to find 1platform download link...they probably changed the poorly designed download page =( : $error"
}

$tempFile =   New-TemporaryFile | Rename-Item -NewName { $_ -replace '$', '.exe' } -PassThru
$tempPath = $tempFile.FullName
$processRunning = $false
Try {
  Try {
    Invoke-WebRequest -Uri $downloadUri -OutFile $tempPath
  }
  Catch {
    $error = $_.Exception.Message
    throw "Failed to download 1platform installer: $error";
  }

  $proc = Start-Process $tempPath -ArgumentList ("/VERYSILENT") -NoNewWindow -PassThru
  $processRunning = $true
  If (!$proc.WaitForExit($1passwordInstallationTimeoutSeconds*1000))
  {
    $processId = $proc.Id;
    $processName = $proc.ProcessName
    throw "1password install timedout (process [$processId] $processName). It may or may not have been successful!"
  }
  $processRunning = false

  $exitCode = $proc.ExitCode
  If ($exitCode) {
    throw "Error installing 1password (exit code ${exitCode})"
  }
}
Finally {
  If (-Not $processRunning)
  {
    $tempFile.Delete()
  }
  Else {
    Add-Manual-Step -Title "1Password Cleanup" -Lines (
      "The 1password installer was downloaded but did not complete as expected, so we were",
      "unable to delete the installation file. You will want to manually delete it from the",
      "following path:",
      "> $tempPath"
    )
  }
}
