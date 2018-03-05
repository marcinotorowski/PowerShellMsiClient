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
    if ([MsiInterop]::MsiGetProductInfo($guid, $propertyName, $null,  [ref]$buffer) -eq 0)
    {
       $buffer++;

        if ($buffer -gt $stringBuilder.Capacity)
        {
            $stringBuilder.Capacity = $buffer;
        }

        [MsiInterop]::MsiGetProductInfo($guid, $propertyName, $stringBuilder, [ref]$buffer) | Out-Null;
        $stringBuilder.ToString(0, $buffer);
    }    
}