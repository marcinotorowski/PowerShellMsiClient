<#  
    .SYNOPSIS
    Removes MSI package(s) installed locally.
    .DESCRIPTION
    Uses Windows Installer API and removes the selected package.
    .LINK
    https://github.com/marcinotorowski/PowerShellMsiClient
    .EXAMPLE
    Remove-MsiClientPackage -PackageId 90160000-008c-0000-0000-0000000ff1ce
    This will remove the package with specific GUID (ProductCode)
#>
function Remove-MsiClientPackage
{
    [CmdletBinding()]
    Param(    
        [Parameter(Mandatory = $true, HelpMessage = 'The GUID of the package.', Position = 0, ParameterSetName = "ById", ValueFromPipeline = $true)]
        [Alias("ProductCode", "Id")]
        [string]$PackageId,
        [Parameter(Mandatory = $true, HelpMessage = 'The package to be uninstalled.', Position = 0, ParameterSetName = "ByPackage", ValueFromPipeline = $true)]
        [Alias("Pkg", "p")]
        [MsiClientPackage]$Package
    )
    
    if (-not [string]::IsNullOrEmpty($PackageId))
    {
        $Package = Get-MsiClientPackage $PackageId;
    }

    $location = $Package.Properties['LocalPackage'];
    
    [IntPtr]$hwnd = [IntPtr]::Zero;
	[MsiInterop]::MsiSetInternalUI($INSTALLUILEVEL_BASIC, [ref]$hwnd);
    $result = [MsiInterop]::MsiInstallProduct($location, "REMOVE=ALL");
}