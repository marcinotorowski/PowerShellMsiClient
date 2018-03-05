<#  
	.SYNOPSIS
	Gets MSI package(s) installed locally.
	.DESCRIPTION
	Uses Windows Installer API and returns the information about select package or all packages.
	.LINK
	https://github.com/marcinotorowski/PowerShellMsiClient
	.EXAMPLE
	Get-MsiClientPackage
    This will get all MSI packages installed or advertised locally
    .EXAMPLE
    Get-MsiClientPackage -PackageId 90160000-008c-0000-0000-0000000ff1ce
    This will get a package with a specific ProductCode.
#>
function Get-MsiClientPackage
{
	[CmdletBinding()]
    Param(
	
		[Parameter(Mandatory = $false, HelpMessage = 'The GUID of the package.', Position = 0)]
		[ValidateNotNullOrEmpty()]
		[string]$PackageId
	)
	
	[System.Guid]$actualGuid = [System.Guid]::Empty;
	[bool]$specific = $false;
	
	if (-not [string]::IsNullOrEmpty($PackageId))
	{
		$specific = $true;
		[System.Guid]$actualGuid= New-Object System.Guid $PackageId;
	}
	
	[System.Text.StringBuilder]$stringBuilder = New-Object System.Text.StringBuilder 40;
	[System.Text.StringBuilder]$tempStringBuilder = New-Object System.Text.StringBuilder 0;

	[UInt32]$j = 0;
	[UInt32]$res = 0;

	while (($res = [MsiInterop]::MsiEnumProducts($j, $stringBuilder)) -eq 0)
	{
		$guid = $stringBuilder.ToString();
		$parsedGuid = [System.Guid]::Parse($guid);
		
		if ((-not $specific) -or ($parsedGuid -eq $actualGuid))
		{
			$c = New-Object MsiClientPackage;
			$c.ProductCode = $parsedGuid;	
			$c.PackageName = Get-MsiProperty $guid "PackageName" $tempStringBuilder;
			$c.ProductName = Get-MsiProperty $guid "ProductName" $tempStringBuilder;
			$c.VersionString = Get-MsiProperty $guid "VersionString" $tempStringBuilder;
			$c.Language = Get-MsiProperty $guid "Language" $tempStringBuilder;
			$c.Publisher = Get-MsiProperty $guid "Publisher" $tempStringBuilder;
			$c.State = Get-MsiProperty $guid "State" $tempStringBuilder;
			$c.Transforms = Get-MsiProperty $guid "Transforms" $tempStringBuilder;
			$c.DisplayName = Get-MsiProperty $guid "DisplayName" $tempStringBuilder;
			$c.PackageCode = Get-MsiProperty $guid "PackageCode" $tempStringBuilder;
			$c.AssignmentType = Get-MsiProperty $guid "AssignmentType" $tempStringBuilder;
			$c.InstanceType = Get-MsiProperty $guid "InstanceType" $tempStringBuilder;
			$c.AuthorizedLUAApp = Get-MsiProperty $guid "AuthorizedLUAApp" $tempStringBuilder;
			$c.Version = Get-MsiProperty $guid "Version" $tempStringBuilder;
			$c.ProductIcon = Get-MsiProperty $guid "ProductIcon" $tempStringBuilder;
			$c.InstalledProductName = Get-MsiProperty $guid "InstalledProductName" $tempStringBuilder;
			$c.HelpLink = Get-MsiProperty $guid "HelpLink" $tempStringBuilder;
			$c.HelpTelephone = Get-MsiProperty $guid "HelpTelephone" $tempStringBuilder;
			$c.InstallLocation = Get-MsiProperty $guid "InstallLocation" $tempStringBuilder;
			$c.InstallSource = Get-MsiProperty $guid "InstallSource" $tempStringBuilder;
			$c.InstallDate = Get-MsiProperty $guid "InstallDate" $tempStringBuilder;
			$c.LocalPackage = Get-MsiProperty $guid "LocalPackage" $tempStringBuilder;
			$c.URLInfoAbout = Get-MsiProperty $guid "URLInfoAbout" $tempStringBuilder;
			$c.URLUpdateInfo = Get-MsiProperty $guid "URLUpdateInfo" $tempStringBuilder;
			$c.VersionMinor = Get-MsiProperty $guid "VersionMinor" $tempStringBuilder;
			$c.VersionMajor = Get-MsiProperty $guid "VersionMajor" $tempStringBuilder;
			$c.RegCompany = Get-MsiProperty $guid "RegCompany" $tempStringBuilder;
			$c.RegOwner = Get-MsiProperty $guid "RegOwner" $tempStringBuilder;
			$c.Uninstallable = Get-MsiProperty $guid "Uninstallable" $tempStringBuilder;
			$c.PatchType = Get-MsiProperty $guid "PatchType" $tempStringBuilder;
			$c.LUAEnabled = Get-MsiProperty $guid "LUAEnabled" $tempStringBuilder;
			$c.MoreInfoURL = Get-MsiProperty $guid "MoreInfoURL" $tempStringBuilder;
			$c.LastUsedSource = Get-MsiProperty $guid "LastUsedSource" $tempStringBuilder;
			$c.LastUsedType = Get-MsiProperty $guid "LastUsedType" $tempStringBuilder;
			$c.MediaPackagePath = Get-MsiProperty $guid "MediaPackagePath" $tempStringBuilder;
			$c.DiskPrompt = Get-MsiProperty $guid "DiskPrompt" $tempStringBuilder;

			Write-Output ($c);
		}
		
		$j++;
	}
}