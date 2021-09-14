@{
  ExcludeRules = @('PSAvoidUsingWriteHost','PSMissingModuleManifestField')
  Rules = @{
    PSAvoidUsingCmdletAliases = @{Whitelist = @('cd')}
    PSUseCompatibleSyntax = @{
      Enable = $true
      TargetVersions = @(
          '5.1',
          '7.1'
      )
    }
}
