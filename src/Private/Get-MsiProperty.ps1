<#
Helper function to get an MSI property for an installed product from Windows Installer API
#>
function Get-MsiProperty
{
    [CmdletBinding()]
    Param(
    
        [Parameter(Mandatory = $true, HelpMessage = 'The GUID representing ProductCode.', ValueFromPipeline = $true, Position = 0)]
        [ValidateNotNullOrEmpty()]
        [string]$guid, 
        
        [Parameter(Mandatory = $true, HelpMessage = 'The name of the property to get.', Position = 1)]
        [ValidateNotNullOrEmpty()]
        [string]$propertyName, 
        
        [Parameter(Mandatory = $true, HelpMessage = 'The string builder that will hold the value.', Position = 2)]
        [System.Text.StringBuilder]$stringBuilder
    )
    
    [int]$buffer = 0;
    [UInt32]$returnCode = [MsiInterop]::MsiGetProductInfo($guid, $propertyName, $null,  [ref]$buffer);
    if ($returnCode -eq $ERROR_SUCCESS)
    {
       $buffer++;

        if ($buffer -gt $stringBuilder.Capacity)
        {
            $stringBuilder.Capacity = $buffer;
        }

        $returnCode = [MsiInterop]::MsiGetProductInfo($guid, $propertyName, $stringBuilder, [ref]$buffer);
        if ($returnCode -eq $ERROR_SUCCESS)
        {
            $stringBuilder.ToString(0, $buffer);
        }
    }    
}