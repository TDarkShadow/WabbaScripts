#Requires -Modules PsIni

If ((Test-Path -Path "$env:LOCALAPPDATA\Wabbajack") -ne $true) {
  Write-Error -Message "Wabbajack data folder doesn't exist. Please start Wabbajack first."
  Write-Host -NoNewLine "Press any key to continue...";
  $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
  Exit
}
$WJsettings = Get-Content -Raw -Path "$env:LOCALAPPDATA\Wabbajack\settings.json" | ConvertFrom-Json

If (Test-Path "${PSScriptRoot}\..\wjcompile.ini") {
  $WJCompileINI = Get-IniContent "${PSScriptRoot}\..\wjcompile.ini"
} ElseIf (Test-Path "${PSScriptRoot}\wjcompile.ini") {
  $WJCompileINI = Get-IniContent "${PSScriptRoot}\wjcompile.ini"
} Else {
  $WJCompileINI = Get-IniContent (Read-Host "Please enter the location of wjcompile.ini")
}

If (Test-Path ($WJCompileINI.DirectoryName + "\wjcompile.local.ini")) {
  $WJCompileINI += Get-IniContent "${PSScriptRoot}\..\wjcompile.ini"
} Else {
  $WJCompileINI += Get-IniContent (Read-Host "Please enter the location of wjcompile.ini")
}

# TODO: Clean out $WJsettings.Compiler, replace with $WJCompileINI.Values