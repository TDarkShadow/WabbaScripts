If ((Test-Path -Path "$env:LOCALAPPDATA\Wabbajack") -ne $true) {
  Write-Error -Message "Wabbajack data folder doesn't exist. Please start Wabbajack first."
  Write-Host -NoNewLine "Press any key to continue...";
  $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
  Exit
}
$WJsettings = Get-Content -Raw -Path "$env:LOCALAPPDATA\Wabbajack\settings.json" | ConvertFrom-Json


# TODO: Check wabbajack.meta or manifest file, and get name of modlist.
If ((Test-Path -Path "$PSScriptRoot\wjcompile.toml") -ne $true) {
  $ModlistLocation = Read-Host 'Where is your modlist located?'
} Else {
  $ModlistLocation = "$PSScriptRoot\wjcompile.toml"
}

# TODO: Check and create function for wjcompile.toml file
If ((Test-Path -Path "$PSScriptRoot\wjcompile.toml") -ne $true) {
  $ModlistLocation = Read-Host 'Where is your modlist located?'
} Else {
  $ModlistLocation = "$PSScriptRoot\wjcompile.toml"
}
