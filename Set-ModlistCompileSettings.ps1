#Requires -Modules PsIni

# Check if Wabbajack settings file exist.
# If not, exit the script with a warning to the user.
If ((Test-Path -Path "$env:LOCALAPPDATA\Wabbajack") -ne $true) {
  Write-Error -Message "Wabbajack data folder doesn't exist. Please start Wabbajack first."
  Write-Host -NoNewLine "Press any key to continue...";
  $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
  Exit
}
$WJsettings = Get-Content -Raw -Path "$env:LOCALAPPDATA\Wabbajack\settings.json" | ConvertFrom-Json

# Get the contents of the general wjcompile ini if possible.
# Checking the parent folder first, ...
If (Test-Path "${PSScriptRoot}\..\wjcompile.ini") {
  $WJCompileINI = Get-IniContent "${PSScriptRoot}\..\wjcompile.ini"
# then the root folder.
} ElseIf (Test-Path "${PSScriptRoot}\wjcompile.ini") {
  $WJCompileINI = Get-IniContent "${PSScriptRoot}\wjcompile.ini"
# If still not found, ask the user for the location.
} Else {
  $WJCompileINILocation = Read-Host "Please enter the location of wjcompile.ini"
  If ((Test-Path -Path $WJCompileINILocation) -ne $true) {
    Write-Error -Message "Wabbajack Compile INI file doesn't exist. Please create one first."
    Write-Host -NoNewLine "Press any key to continue...";
    $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
    Exit
  }
  $WJCompileINI = Get-IniContent $WJCompileINILocation
}

# Get the contents of the local wjcompile ini if possible.
# Checking the same folder of the general wjcompile ini first, ...
If (Test-Path ($WJCompileINI.DirectoryName + "\wjcompile.local.ini")) {
  $WJCompileINI += Get-IniContent ($WJCompileINI.DirectoryName + "\wjcompile.local.ini")
} Else {
  # If still not found, ask the user for the location.
  $WJCompileINILocalLocation = Read-Host "Please enter the location of wjcompile.local.ini"
  If ((Test-Path -Path $WJCompileINILocalLocation) -ne $true) {
    Write-Error -Message "Wabbajack Compile Local INI file doesn't exist. Please create one first."
    Write-Host -NoNewLine "Press any key to continue...";
    $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
    Exit
  }
  $WJCompileINI += Get-IniContent $WJCompileINILocalLocation
}

# Assembling the compilation settings block 
$WJsettings.Compiler.OutputLocation = $WJCompileINI.Local.OutputLocation
$WJsettings.Compiler.MO2Compilation.DownloadLocation = $WJCompileINI.Local.DownloadLocation
$WJsettings.Compiler.MO2Compilation.LastCompiledProfileLocation = $WJCompileINI.Local.ModlistLocation
$ModlistLocation = $WJCompileINI.Local.ModlistLocation
$ModListName = $WJCompileINI.General.ModListName
$ModListVersion = $WJCompileINI.General.Version
$ModListAuthor = $WJCompileINI.General.Author
$ModListDescription = $WJCompileINI.General.Description
$ModListWebsite =  $WJCompileINI.General.Website
$ModListReadme =  $WJCompileINI.General.Readme
$ModListIsNSFW = $WJCompileINI.General.IsNSFW
$ModListSplashScreen = $WJCompileINI.Local.SplashScreenLocation
$ModListPublish = $WJCompileINI.General.Publish
$CompilationSettings = [PSCustomObject]@{
  ModListName = "$ModListName"
  Version = $ModListVersion
  Author = "$ModListAuthor"
  Description = "$ModListDescription"
  Website = "$ModListWebsite"
  Readme = "$ModListReadme"
  IsNSFW = $ModlistIsNSFW
  SplashScreen = "$ModListSplashScreen"
  Publish = $ModListPublish
}
$WJsettings.Compiler.MO2Compilation.ModlistSettings | Add-Member -Name $ModlistLocation -Value $CompilationSettings -MemberType NoteProperty -Force

# Export the compile settings to the Wabbajack settings.
$WJsettings | ConvertTo-Json -depth 100 -Compress | Set-Content "$env:LOCALAPPDATA\Wabbajack\settings.json"
