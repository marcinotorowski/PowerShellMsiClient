<# The function succeeded. #>
New-Variable -Name 'ERROR_SUCCESS' -Value (0 -as [UInt32]) -Option Constant
<# Administrator privileges are required to enumerate components of applications installed by users other than the current user. #>
New-Variable -Name 'ERROR_ACCESS_DENIED' -Value (5 -as [UInt32]) -Option Constant
<# The configuration data is corrupt. #>
New-Variable -Name 'ERROR_BAD_CONFIGURATION' -Value (1610 -as [UInt32]) -Option Constant
<# An invalid parameter is passed to the function. #>
New-Variable -Name 'ERROR_INVALID_PARAMETER' -Value (87 -as [UInt32]) -Option Constant
<# There are no more components to enumerate. #>
New-Variable -Name 'ERROR_NO_MORE_ITEMS' -Value (259 -as [UInt32]) -Option Constant
<# The provided buffer was too small to hold the entire value. #>
New-Variable -Name 'ERROR_MORE_DATA' -Value (234 -as [UInt32]) -Option Constant
<# The function failed. #>
New-Variable -Name 'ERROR_FUNCTION_FAILED' -Value (1627 -as [UInt32]) -Option Constant