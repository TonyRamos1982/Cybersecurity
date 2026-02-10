<#
.SYNOPSIS
    WN11-CC-000090 Remediation
    Ensure Group Policy objects are reprocessed even if unchanged

.NOTES
    Author          : Tony Ramos
    LinkedIn        : linkedin.com/in/tony-ramos1982/
    GitHub          : github.com/tonyramos1982
    Date Created    : 2026-02-09
    Last Modified   : 2026-02-09
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-CC-000090

.TESTED ON
    Date(s) Tested  : 2026-02-09
    Tested By       : Tony Ramos
    Systems Tested  : windows11
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\WN11-CC-000090.ps1
#>

# Check for Administrator privileges
If (-not ([Security.Principal.WindowsPrincipal] `
    [Security.Principal.WindowsIdentity]::GetCurrent()
    ).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Error "This script must be run as Administrator."
    Exit 1
}

$RegPath  = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Group Policy"
$ValueName = "DisableBackgroundPolicy"
$ValueData = 0

# Create registry key if it doesn't exist
If (-not (Test-Path $RegPath)) {
    New-Item -Path $RegPath -Force | Out-Null
}

# Set the required value
New-ItemProperty `
    -Path $RegPath `
    -Name $ValueName `
    -PropertyType DWORD `
    -Value $ValueData `
    -Force | Out-Null

Write-Output "WN11-CC-000090 remediation applied successfully."

# Check to verify DisableBackgroundPolicy : 0

Get-ItemProperty `
  -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Group Policy" `
  -Name DisableBackgroundPolicy
