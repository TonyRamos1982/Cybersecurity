<#
.SYNOPSIS
    WN11-SO-000075 Remediation
    Configure legal notice before console logon

.NOTES
    Author          : Tony Ramos
    LinkedIn        : linkedin.com/in/tony-ramos1982/
    GitHub          : github.com/tonyramos1982
    Date Created    : 2026-02-09
    Last Modified   : 2026-02-09
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-SO-000075

.TESTED ON
    Date(s) Tested  : 2026-02-09
    Tested By       : Tony Ramos
    Systems Tested  : windows11
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\WN11-SO-000075.ps1
#>

# Ensure script is running as Administrator
If (-not ([Security.Principal.WindowsPrincipal] `
    [Security.Principal.WindowsIdentity]::GetCurrent()
    ).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Error "This script must be run as Administrator."
    Exit 1
}

$RegPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"

$LegalCaption = "NOTICE"
$LegalText = @"
This computer system is the property of the U.S. Government.
It is for authorized use only.

Users (authorized or unauthorized) have no explicit or implicit
expectation of privacy.

Any or all uses of this system and all files on this system may be
intercepted, monitored, recorded, copied, audited, inspected, and
disclosed to authorized personnel.

By using this system, you consent to such monitoring.

Unauthorized use of this system may subject you to criminal prosecution.
"@

# Create registry path if it does not exist
If (-not (Test-Path $RegPath)) {
    New-Item -Path $RegPath -Force | Out-Null
}

# Set Legal Notice Caption
Set-ItemProperty `
    -Path $RegPath `
    -Name "LegalNoticeCaption" `
    -Value $LegalCaption

# Set Legal Notice Text
Set-ItemProperty `
    -Path $RegPath `
    -Name "LegalNoticeText" `
    -Value $LegalText

Write-Output "WN11-SO-000075 remediation applied successfully."
Write-Output "Legal notice will display at next logon."
