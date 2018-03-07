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

    while (($res = [MsiInterop]::MsiEnumProducts($j++, $stringBuilder)) -eq $ERROR_SUCCESS)
    {
        $guid = $stringBuilder.ToString();
        $parsedGuid = [System.Guid]::Parse($guid);
        
        if ((-not $specific) -or ($parsedGuid -eq $actualGuid))
        {
            $c = New-Object MsiClientPackage;
            $d = New-Object 'System.Collections.Generic.Dictionary[[string],[string]]';

            $d['ProductCode'] = $guid;    
            $d['PackageCode'] = Get-MsiProperty $guid "PackageCode" $tempStringBuilder;

            if ([string]::IsNullOrEmpty($d['PackageCode']))
            {
                continue;
            }

            $d['PackageName'] = Get-MsiProperty $guid "PackageName" $tempStringBuilder;
            $d['ProductName'] = Get-MsiProperty $guid "ProductName" $tempStringBuilder;
            $d['VersionString'] = Get-MsiProperty $guid "VersionString" $tempStringBuilder;
            $d['Language'] = Get-MsiProperty $guid "Language" $tempStringBuilder;
            $d['Publisher'] = Get-MsiProperty $guid "Publisher" $tempStringBuilder;
            $d['State'] = Get-MsiProperty $guid "State" $tempStringBuilder;
            $d['Transforms'] = Get-MsiProperty $guid "Transforms" $tempStringBuilder;
            $d['DisplayName'] = Get-MsiProperty $guid "DisplayName" $tempStringBuilder;
            $d['AssignmentType'] = Get-MsiProperty $guid "AssignmentType" $tempStringBuilder;
            $d['InstanceType'] = Get-MsiProperty $guid "InstanceType" $tempStringBuilder;
            $d['AuthorizedLUAApp'] = Get-MsiProperty $guid "AuthorizedLUAApp" $tempStringBuilder;
            $d['Version'] = Get-MsiProperty $guid "Version" $tempStringBuilder;
            $d['ProductIcon'] = Get-MsiProperty $guid "ProductIcon" $tempStringBuilder;
            $d['InstalledProductName'] = Get-MsiProperty $guid "InstalledProductName" $tempStringBuilder;
            $d['HelpLink'] = Get-MsiProperty $guid "HelpLink" $tempStringBuilder;
            $d['HelpTelephone'] = Get-MsiProperty $guid "HelpTelephone" $tempStringBuilder;
            $d['InstallLocation'] = Get-MsiProperty $guid "InstallLocation" $tempStringBuilder;
            $d['InstallSource'] = Get-MsiProperty $guid "InstallSource" $tempStringBuilder;
            $d['InstallDate'] = Get-MsiProperty $guid "InstallDate" $tempStringBuilder;
            $d['LocalPackage'] = Get-MsiProperty $guid "LocalPackage" $tempStringBuilder;
            $d['URLInfoAbout'] = Get-MsiProperty $guid "URLInfoAbout" $tempStringBuilder;
            $d['URLUpdateInfo'] = Get-MsiProperty $guid "URLUpdateInfo" $tempStringBuilder;
            $d['VersionMinor'] = Get-MsiProperty $guid "VersionMinor" $tempStringBuilder;
            $d['VersionMajor'] = Get-MsiProperty $guid "VersionMajor" $tempStringBuilder;
            $d['RegCompany'] = Get-MsiProperty $guid "RegCompany" $tempStringBuilder;
            $d['RegOwner'] = Get-MsiProperty $guid "RegOwner" $tempStringBuilder;
            $d['Uninstallable'] = Get-MsiProperty $guid "Uninstallable" $tempStringBuilder;
            $d['PatchType'] = Get-MsiProperty $guid "PatchType" $tempStringBuilder;
            $d['LUAEnabled'] = Get-MsiProperty $guid "LUAEnabled" $tempStringBuilder;
            $d['MoreInfoURL'] = Get-MsiProperty $guid "MoreInfoURL" $tempStringBuilder;
            $d['LastUsedSource'] = Get-MsiProperty $guid "LastUsedSource" $tempStringBuilder;
            $d['LastUsedType'] = Get-MsiProperty $guid "LastUsedType" $tempStringBuilder;
            $d['MediaPackagePath'] = Get-MsiProperty $guid "MediaPackagePath" $tempStringBuilder;
            $d['DiskPrompt'] = Get-MsiProperty $guid "DiskPrompt" $tempStringBuilder;

            $c.Properties = $d;
            
            $c.InstallDate = [DateTime]::MinValue;
            if (-not [string]::IsNullOrEmpty($d['InstallDate']))
            {
                [DateTime]$dt = [DateTime]::MinValue;
                if ([DateTime]::TryParseExact($d['InstallDate'], "yyyyMMdd", [System.Globalization.CultureInfo]::InvariantCulture, 0, [ref] $dt))
                {
                    $c.InstallDate = $dt;
                }
            }

            $c.InstallSource = $d['InstallSource'];
            $c.Language = $d['Language'];
            $c.PackageCode = [System.Guid]::Parse($d['PackageCode']);
            $c.PackageName = $d['PackageName'];
            $c.ProductCode = [System.Guid]::Parse($d['ProductCode']);
            $c.ProductName = $d['ProductName'];
            $c.Publisher = $d['Publisher'];
            $c.Transforms = $d['Transforms'];
            $c.VersionString = $d['VersionString'];
            
            Write-Output ($c);
        }
    }
}