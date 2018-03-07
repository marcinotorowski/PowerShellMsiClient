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
<# broken #>
New-Variable -Name 'INSTALLSTATE_BROKEN' -Value (0 -as [UInt32]) -Option Constant
<# advertised feature #>
New-Variable -Name 'INSTALLSTATE_ADVERTISED' -Value (1 -as [UInt32]) -Option Constant
<# uninstalled (or action state absent but clients remain) #>
New-Variable -Name 'INSTALLSTATE_ABSENT' -Value (2 -as [UInt32]) -Option Constant
 <# installed on local drive #>
New-Variable -Name 'INSTALLSTATE_LOCAL' -Value (3 -as [UInt32]) -Option Constant
<# run from source, CD or net #>
New-Variable -Name 'INSTALLSTATE_SOURCE' -Value (4 -as [UInt32]) -Option Constant

New-Variable -Name 'INSTALLUILEVEL_NOCHANGE' -Value (0 -as [UInt32]) -Option Constant
New-Variable -Name 'INSTALLUILEVEL_DEFAULT' -Value (1 -as [UInt32]) -Option Constant
New-Variable -Name 'INSTALLUILEVEL_NONE' -Value (2 -as [UInt32]) -Option Constant
New-Variable -Name 'INSTALLUILEVEL_BASIC' -Value (3 -as [UInt32]) -Option Constant
New-Variable -Name 'INSTALLUILEVEL_REDUCED' -Value (4 -as [UInt32]) -Option Constant
New-Variable -Name 'INSTALLUILEVEL_FULL' -Value (5 -as [UInt32]) -Option Constant
New-Variable -Name 'INSTALLUILEVEL_ENDDIALOG' -Value (0x80 -as [UInt32]) -Option Constant
New-Variable -Name 'INSTALLUILEVEL_PROGRESSONLY' -Value (0x40 -as [UInt32]) -Option Constant
New-Variable -Name 'INSTALLUILEVEL_HIDECANCEL' -Value (0x20 -as [UInt32]) -Option Constant
New-Variable -Name 'INSTALLUILEVEL_SOURCERESONLY' -Value (0x100 -as [UInt32]) -Option Constant
