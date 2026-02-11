<#
.SYNOPSIS
    WN11-SO-000025 Remediation
    Rename the built-in Guest account

.NOTES
    Author          : Tony Ramos
    LinkedIn        : linkedin.com/in/tony-ramos1982/
    GitHub          : github.com/tonyramos1982
    Date Created    : 2026-02-10
    Last Modified   : 2026-02-10
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-UR-000070

.TESTED ON
    Date(s) Tested  : 2026-02-10
    Tested By       : Tony Ramos
    Systems Tested  : windows11
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\WN11-SO-000025.ps1
#>


# Ensure script is running as Administrator
If (-not ([Security.Principal.WindowsPrincipal] `
    [Security.Principal.WindowsIdentity]::GetCurrent()
).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Error "This script must be run as Administrator."
    Exit 1
}

# New name for the Guest account (change if your org has a standard)
$NewGuestName = "Visitor_501"

# Get the built-in Guest account by SID (RID 501)
$GuestAccount = Get-LocalUser | Where-Object {
    $_.SID -match "-501$"
}

if (-not $GuestAccount) {
    Write-Error "Built-in Guest account not found."
    Exit 1
}

# Rename the Guest account
Rename-LocalUser `
    -Name $GuestAccount.Name `
    -NewName $NewGuestName

Write-Output "WN11-SO-000025 remediation applied successfully."
Write-Output "Built-in Guest account renamed to '$NewGuestName'."
