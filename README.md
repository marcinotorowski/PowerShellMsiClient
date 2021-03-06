# MsiClient

This is a small PowerShell module project which aims at exposing Windows Installer API through a PowerShell interface, which is highly inspired by the layout and use of AppVClient module.
## Importing
Either copy the files to a system-recognized location or make sure they are in your working directory, and then import the module
```powershell
Import-Module MsiClient
```
## Samples
### Getting all packages
```powershell
Get-MsiClientPackage
```
For available properties, see the next example.

### Getting specific packages by GUID (ProductCode)
```powershell
Get-MsiClientPackage -PackageId '90160000-008c-0000-0000-0000000ff1ce'
````
or
```powershell
Get-MsiClientPackage '90160000-008c-0000-0000-0000000ff1ce'
```
The output is a class with the following properties (sample values provided for a reference):

````
ProductCode   : 90160000-008c-0000-0000-0000000ff1ce
PackageCode   : 7afb57da-76ca-4406-8979-ad7fd1365320
ProductName   : Office 16 Click-to-Run Extensibility Component
VersionString : 16.0.9029.2167
Language      : 0
Publisher     : Microsoft Corporation
PackageName   : C2RInt.16.msi
Transforms    :
InstallSource : c:\program files (x86)\microsoft office\root\integration\
InstallDate   : 04.03.2018 00:00:00
Properties    : {[ProductCode, {90160000-008C-0000-0000-0000000FF1CE}], [PackageCode, {7AFB57DA-76CA-4406
                -8979-AD7FD1365320}], [PackageName, C2RInt.16.msi], [ProductName, Office 16 Click-to-Run
                Extensibility Component]...}
````

The property Properties is a dictionary which contains all values available at the time of reading, for example:

| Key | Value |
|--|--|
| ProductCode          | 90160000-008c-0000-0000-0000000ff1ce |
| ProductID            | |
| PackageName          | C2RInt.16.msi |
| ProductName          | Office 16 Click-to-Run Extensibility Component |
| VersionString        | 16.0.9029.2167 |
| Language             | 0 |
| Publisher            | Microsoft Corporation |
| State                | |
| Transforms           | |
| DisplayName          | |
| PackageCode          | {7AFB57DA-76CA-4406-8979-AD7FD1365320} |
| AssignmentType       | 1 |
| InstanceType         | 0 |
| AuthorizedLUAApp     | 0 |
| Version              | 268444485 |
| ProductIcon          | |
| InstalledProductName | Office 16 Click-to-Run Extensibility Component |
| HelpLink             | |
| HelpTelephone        | |
| InstallLocation      | |
| InstallSource        | c:\program files (x86)\microsoft office\root\integration\ |
| InstallDate          | 20180304 |
| LocalPackage         | c:\WINDOWS\Installer\5ad3e8de.msi |
| URLInfoAbout         | |
| URLUpdateInfo        | |
| VersionMinor         | 0 |
| VersionMajor         | 16 |
| RegCompany           | |
| RegOwner             | |
| Uninstallable        | |
| PatchType            | |
| LUAEnabled           | |
| MoreInfoURL          | |
| LastUsedSource       | n;1;c:\program files (x86)\microsoft office\root\integration\ |
| LastUsedType         | n;1;c:\program files (x86)\microsoft office\root\integration\ |
| MediaPackagePath     | |
| DiskPrompt           | |

### Uninstalling a package
```powershell
Remove-MsiClientPackage -PackageId '90160000-008c-0000-0000-0000000ff1ce'
```
This removes a package with a given GUID. The GUID/package can be passed via pipeline, so the following is possible:
```powershell
Get-MsiClientPackage | where { $_.ProductName -contains 'Microsoft' } | Remove-MsiClientPackage
```
This removes all products from Microsoft :).

### Fancy usage
Get all products from Microsoft, and output the list to a HTML file with a custom CSS and a bunch of properties:
```powershell
$Header = @"
  <style>
  TABLE {border: 1px solid gray collapse; }
  TH { border: 1px solid gray; padding: 6px 4px; background-color: #eaeaea; }
  TD { border: 1px solid gray; padding: 4px; }
</style>
"@
Get-MsiClientPackage | where { $_.Publisher -contains 'Microsoft Corporation' } | sort-object -Property ProductName | ConvertTo-Html -Property ProductCode,PackageName,ProductName,VersionString,Language,Publisher -Head $Header | Out-File c:\temp\test.html
````
