<#
.SYNOPSIS
    WN11-CC-000315 Remediation
    The Windows Installer feature 'Always install with elevated privileges' must be disabled.

.NOTES
    Author          : Tony Ramos
    LinkedIn        : linkedin.com/in/tony-ramos1982/
    GitHub          : github.com/tonyramos1982
    Date Created    : 2026-02-09
    Last Modified   : 2026-02-09
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-CC-000315

.TESTED ON
    Date(s) Tested  : 2026-02-09
    Tested By       : Tony Ramos
    Systems Tested  : windows11
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\WN11-CC-0002315.ps1
#>

# WN11-CC-000315 Remediation
# Disable "Always install with elevated privileges"

# Ensure script is running as Administrator
If (-not ([Security.Principal.WindowsPrincipal] `
    [Security.Principal.WindowsIdentity]::GetCurrent()
    ).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Error "This script must be run as Administrator."
    Exit 1
}

$RegPaths = @(
    "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Installer",
    "HKCU:\SOFTWARE\Policies\Microsoft\Windows\Installer"
)

$ValueName = "AlwaysInstallElevated"
$ValueData = 0

foreach ($Path in $RegPaths) {

    # Create registry path if it does not exist
    if (-not (Test-Path $Path)) {
        New-Item -Path $Path -Force | Out-Null
    }

    # Set registry value to disabled (0)
    New-ItemProperty `
        -Path $Path `
        -Name $ValueName `
        -PropertyType DWORD `
        -Value $ValueData `
        -Force | Out-Null
}

Write-Output "WN11-CC-000315 remediation applied successfully."

# Check if the property AlwaysInstallElevated : 0 

Get-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Installer" -Name AlwaysInstallElevated
Get-ItemProperty -Path "HKCU:\SOFTWARE\Policies\Microsoft\Windows\Installer" -Name AlwaysInstallElevated
