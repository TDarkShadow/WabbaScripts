#Requires -Modules PsIni

# Get the contents of the local wjcompile ini if possible.
# Checking the parent folder first, ...
If (Test-Path "${PSScriptRoot}\..\wjcompile.local.ini") {
  $WJCompileINI = Get-IniContent "${PSScriptRoot}\..\wjcompile.local.ini"
# then the root folder.
} ElseIf (Test-Path "${PSScriptRoot}\wjcompile.local.ini") {
  $WJCompileINI = Get-IniContent "${PSScriptRoot}\wjcompile.local.ini"
# If still not found, ask the user for the location.
} Else {
  $WJLocalCompileINILocation = Read-Host "Please enter the location of wjcompile.local.ini"
  If ((Test-Path -Path $WJLocalCompileINILocation) -ne $true) {
    Write-Error -Message "wjcompile.local.ini file doesn't exist. Please create one first."
    Write-Host -NoNewLine "Press any key to continue...";
    $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
    Exit
  }
  $WJCompileINI = Get-IniContent $WJLocalCompileINILocation
}

# Get modlist location
$ModlistLocation = $WJCompileINI.Local.ModlistLocation
$ModlistLocation = (Get-Item "$ModlistLocation\..\..\..").FullName

# Get all meta.ini from mods
$ModMetas = Get-ChildItem -Path $ModlistLocation\mods\*\meta.ini

# Set "WABBAJACK_ALWAYS_ENABLE" as comments in every meta file
ForEach ($MetaIni in $ModMetas) {
  Set-IniContent -FilePath $MetaIni.FullName -Sections 'General' -NameValuePairs @{'comments'='WABBAJACK_ALWAYS_ENABLE'} | Out-IniFile $MetaIni.FullName -Force
}
