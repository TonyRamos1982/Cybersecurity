<#
.SYNOPSIS
    WN11-EP-000310 Remediation
    Enable Kernel DMA Protection via Virtualization-Based Security

.NOTES
    Author          : Tony Ramos
    LinkedIn        : linkedin.com/in/tony-ramos1982/
    GitHub          : github.com/tonyramos1982
    Date Created    : 2026-02-09
    Last Modified   : 2026-02-09
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-CC-000310

.TESTED ON
    Date(s) Tested  : 2026-02-09
    Tested By       : Tony Ramos
    Systems Tested  : windows11
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\WN11-EP-000310.ps1
#>

# Ensure script is running as Administrator
If (-not ([Security.Principal.WindowsPrincipal] `
    [Security.Principal.WindowsIdentity]::GetCurrent()
    ).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Error "This script must be run as Administrator."
    Exit 1
}

$RegPath = "HKLM:\SYSTEM\CurrentControlSet\Control\DeviceGuard"

# Create registry path if it does not exist
If (-not (Test-Path $RegPath)) {
    New-Item -Path $RegPath -Force | Out-Null
}

# Enable Virtualization-Based Security
New-ItemProperty `
    -Path $RegPath `
    -Name "EnableVirtualizationBasedSecurity" `
    -PropertyType DWORD `
    -Value 1 `
    -Force | Out-Null

# Require Secure Boot (required for Kernel DMA Protection)
New-ItemProperty `
    -Path $RegPath `
    -Name "RequirePlatformSecurityFeatures" `
    -PropertyType DWORD `
    -Value 1 `
    -Force | Out-Null

Write-Output "WN11-EP-000310 remediation applied."
Write-Output "A system reboot is required for Kernel DMA Protection to become active."
