<#
.SYNOPSIS
    WN11-CC-000255 Remediation
    Disable WinRM client Digest authentication
.NOTES
    Author          : Tony Ramos
    LinkedIn        : linkedin.com/in/tony-ramos1982/
    GitHub          : github.com/tonyramos1982
    Date Created    : 2026-02-10
    Last Modified   : 2026-02-10
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-CC-000255

.TESTED ON
    Date(s) Tested  : 2026-02-10
    Tested By       : Tony Ramos
    Systems Tested  : windows11
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\WN11-CC-000255.ps1
#>

# Ensure script is running as Administrator
If (-not ([Security.Principal.WindowsPrincipal] `
    [Security.Principal.WindowsIdentity]::GetCurrent()
    ).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Error "This script must be run as Administrator."
    Exit 1
}

$RegPath   = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WinRM\Client"
$ValueName = "AllowDigest"
$ValueData = 0

# Create registry path if it does not exist
if (-not (Test-Path $RegPath)) {
    New-Item -Path $RegPath -Force | Out-Null
}

# Set required value
New-ItemProperty `
    -Path $RegPath `
    -Name $ValueName `
    -PropertyType DWORD `
    -Value $ValueData `
    -Force | Out-Null

Write-Output "WN11-CC-000255 remediation applied successfully."

# Check to confirm remediation value should be 0

Get-ItemProperty `
  -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WinRM\Client" `
  -Name AllowDigest

