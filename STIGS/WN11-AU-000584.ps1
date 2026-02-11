<#
.SYNOPSIS
    WN11-AU-000584 Remediation
    Enable auditing for Object Access - Handle Manipulation (Success)

.NOTES
    Author          : Tony Ramos
    LinkedIn        : linkedin.com/in/tony-ramos1982/
    GitHub          : github.com/tonyramos1982
    Date Created    : 2026-02-10
    Last Modified   : 2026-02-10
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-CC-000584

.TESTED ON
    Date(s) Tested  : 2026-02-10
    Tested By       : Tony Ramos
    Systems Tested  : windows11
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\WN11-AU-000584.ps1
#>

# Ensure script is running as Administrator
If (-not ([Security.Principal.WindowsPrincipal] `
    [Security.Principal.WindowsIdentity]::GetCurrent()
    ).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Error "This script must be run as Administrator."
    Exit 1
}

# Enable Handle Manipulation auditing (Success)
auditpol /set /subcategory:"Handle Manipulation" /success:enable

# Verify configuration
$auditStatus = auditpol /get /subcategory:"Handle Manipulation"

Write-Output "WN11-AU-000584 remediation applied successfully."
Write-Output $auditStatus
