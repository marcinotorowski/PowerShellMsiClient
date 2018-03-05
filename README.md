# PowerShellMsiClient

This is a small project which aims at exposing Windows Installer API through a PowerShell interface, which is highly inspired by the layout and use of AppVClient module.
## Samples
### Getting all packages
    Get-MsiClientPackage

### Getting specific packages by GUID (ProductCode)
    Get-MsiClientPackage -PackageId 90160000-008c-0000-0000-0000000ff1ce
