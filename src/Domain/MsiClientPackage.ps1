class MsiClientPackage
{
    [Guid]$ProductCode;
    [string]$PackageCode;
    [string]$ProductName;
    [string]$VersionString;
    [string]$Language;
    [string]$Publisher;
    [string]$PackageName;
    [string]$Transforms;
    [string]$InstallSource;
    [DateTime]$InstallDate;
    [System.Collections.Generic.Dictionary[[string],[string]]]$Properties;
}