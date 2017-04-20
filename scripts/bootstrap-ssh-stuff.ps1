
. "$PSScriptRoot\util\backups.ps1"
. "$PSScriptRoot\util\manual-work.ps1"

$keySizeBits = 4096
$sshDirPath = "$HOME\.ssh"
$privateKeyPath = "$sshDirPath\id_rsa"
$publicKeyPath = "$privateKeyPath.pub"

Write-Host "Generating SSH Keys..."

If (Test-Path $sshDirPath)
{
  $privateKeyBackupPath = Backup-File -Path $privateKeyPath -Name "id_rsa"
  $publicKeyBackupPath = Backup-File -Path $publicKeyPath -Name "id_rsa.pub"

  $oldPublicKey = $false
  If ($publicKeyBackupPath)
  {
    $oldPublicKey = Get-Content $publicKeyBackupPath
  }
  ElseIf ($privateKeyBackupPath)
  {
    $pinfo = New-Object System.Diagnostics.ProcessStartInfo
    $pinfo.FileName = "C:\Program Files\Git\usr\bin\ssh-keygen.exe"
    $pinfo.RedirectStandardOutput = $true
    $pinfo.UseShellExecute = $false
    $pinfo.Arguments = ("-y", "-f", $privateKeyPath)
    $p = New-Object System.Diagnostics.Process
    $p.StartInfo = $pinfo
    $p.Start() | Out-Null
    $oldPublicKey = $p.StandardOutput.ReadToEnd()
    $p.WaitForExit()
    $exitCode = $p.ExitCode
    If ($exitCode -ne 0)
    {
      throw "Failed to read public key from existin private key (exit code $exitCode)"
    }
  }

  If ($oldPublicKey)
  {
    Add-Manual-Step -Title "Revoke SSH Public Key" -Lines (
      "You already had SSH keys installed on this system under ``$sshDirPath``. It has been backed up to:",
      "> $publicKeyBackupPath",
      "> $privateKeyBackupPath",
      "",
      "A new SSH Key Pair will be generated under ``$sshDirPath``; it is recommended that you *revoke* your previous",
      "SSH Public Key from any system that know about it, so that it can no longer be used. The old public key",
      "(the one you should probably revoke) is:",
      "",
      "> $oldPublicKey"
    )
  }

  # Delete the old files (already backed-up)
  If (Test-Path $privateKeyPath)
  {
      Remove-Item $privateKeyPath
  }

  If (Test-Path $publicKeyPath)
  {
      Remove-Item $publicKeyPath
  }
}
Else {
  New-Item -ItemType "directory" -Path $sshDirPath
}

$proc = Start-Process "C:\Program Files\Git\usr\bin\ssh-keygen.exe" -ArgumentList (
    "-q",
    "-f", $privateKeyPath,
    "-b", $keySizeBits,
    "-C", "$Env:USERNAME@${Env:COMPUTERNAME}.${Env:USERDNSDOMAIN}_$(Get-Date -format yyyy-MM-dd)",
    "-P", "''"  # No password
  ) -Wait -NoNewWindow -PassThru
If ($proc.ExitCode -ne 0)
{
    $exitCode = $proc.ExitCode
    throw "Generating SSH keys failed with exit code $exitCode."
}
Write-Host "...done"

Add-Manual-Step -Title "Publish SSH Public Key" -Lines (
  "Your new SSH key pair has been generated under ``$sshDirPath``. You should now add your new public key",
  "to whatever systems you need to authenticate with. Here are some suggestions:",
  "* [Github](https://github.com/settings/keys)",
  "* Gitlab (``https://`${GITLAB-HOST}/profile/keys``)",
  "",
  "Here is your new SSH public key:",
  "",
  "> $(Get-Content $publicKeyPath)"
)
