<#
.SYNOPSIS
      WN11-UR-000070 Remediation
      Configure "Deny access to this computer from the network"

.NOTES
    Author          : Tony Ramos
    LinkedIn        : linkedin.com/in/tony-ramos1982/
    GitHub          : github.com/tonyramos1982
    Date Created    : 2026-02-09
    Last Modified   : 2026-02-09
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-UR-000070

.TESTED ON
    Date(s) Tested  : 2026-02-09
    Tested By       : Tony Ramos
    Systems Tested  : windows11
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\WN11-UR-000070.ps1
#>

# Ensure script is running as Administrator
If (-not ([Security.Principal.WindowsPrincipal] `
    [Security.Principal.WindowsIdentity]::GetCurrent()
    ).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Error "This script must be run as Administrator."
    Exit 1
}

$TempInf = "$env:TEMP\WN11-UR-000070.inf"
$DbFile  = "$env:TEMP\secedit.sdb"

# SIDs required by STIG
# Guests = S-1-5-32-546
# Local account = S-1-5-113
# Local account and member of Administrators group = S-1-5-114
$DenySIDs = "S-1-5-32-546,S-1-5-113,S-1-5-114"

@"
[Unicode]
Unicode=yes
[System Access]
[Event Audit]
[Registry Values]
[Privilege Rights]
SeDenyNetworkLogonRight = $DenySIDs
"@ | Out-File -FilePath $TempInf -Encoding Unicode -Force

# Apply security policy
secedit /configure /db $DbFile /cfg $TempInf /areas USER_RIGHTS | Out-Null

# Cleanup
Remove-Item $TempInf -Force -ErrorAction SilentlyContinue
Remove-Item $DbFile -Force -ErrorAction SilentlyContinue

Write-Output "WN11-UR-000070 remediation applied successfully."
