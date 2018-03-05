$files_objects = @( Get-ChildItem -Path $PSScriptRoot\Objects\*.ps1 -ErrorAction SilentlyContinue )
$files_private = @( Get-ChildItem -Path $PSScriptRoot\Private\*.ps1 -ErrorAction SilentlyContinue )
$files_public  = @( Get-ChildItem -Path $PSScriptRoot\Public\*.ps1 -ErrorAction SilentlyContinue )

# Dot the sources
foreach($file in @($files_objects + $files_private + $files_public))
{
	Try
	{
		. $file.fullname
	}
	Catch
	{
		Write-Error -Message "Failed to import '$($import.fullname)': $_"
	}
}

Export-ModuleMember -Function Get-MsiClientPackage