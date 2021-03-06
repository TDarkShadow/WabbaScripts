$RegistryPath = "HKLM:\SOFTWARE\WOW6432Node\Bethesda Softworks\Skyrim Special Edition\"
If (Test-Path -Path $RegistryPath) {
  $InstallationPath = Get-ItemProperty -Path $RegistryPath | Select-Object -ExpandProperty "installed path"
} Else {
  Write-Error "Skyrim Special Edition not installed!" -Category NotInstalled; Exit
}

$CC_SkyrimAE = @(
  "ccafdsse001-dwesanctuary.bsa",
  "ccafdsse001-dwesanctuary.esm",
  "ccasvsse001-almsivi.bsa",
  "ccasvsse001-almsivi.esm",
  "ccbgssse002-exoticarrows.bsa",
  "ccbgssse002-exoticarrows.esl",
  "ccbgssse003-zombies.bsa",
  "ccbgssse003-zombies.esl",
  "ccbgssse004-ruinsedge.bsa",
  "ccbgssse004-ruinsedge.esl",
  "ccbgssse005-goldbrand.bsa",
  "ccbgssse005-goldbrand.esl",
  "ccbgssse006-stendarshammer.bsa",
  "ccbgssse006-stendarshammer.esl",
  "ccbgssse007-chrysamere.bsa",
  "ccbgssse007-chrysamere.esl",
  "ccbgssse008-wraithguard.bsa",
  "ccbgssse008-wraithguard.esl",
  "ccbgssse010-petdwarvenarmoredmudcrab.bsa",
  "ccbgssse010-petdwarvenarmoredmudcrab.esl",
  "ccbgssse011-hrsarmrelvn.bsa",
  "ccbgssse011-hrsarmrelvn.esl",
  "ccbgssse012-hrsarmrstl.bsa",
  "ccbgssse012-hrsarmrstl.esl",
  "ccbgssse013-dawnfang.bsa",
  "ccbgssse013-dawnfang.esl",
  "ccbgssse014-spellpack01.bsa",
  "ccbgssse014-spellpack01.esl",
  "ccbgssse016-umbra.bsa",
  "ccbgssse016-umbra.esm",
  "ccbgssse018-shadowrend.bsa",
  "ccbgssse018-shadowrend.esl",
  "ccbgssse019-staffofsheogorath.bsa",
  "ccbgssse019-staffofsheogorath.esl",
  "ccbgssse020-graycowl.bsa",
  "ccbgssse020-graycowl.esl",
  "ccbgssse021-lordsmail.bsa",
  "ccbgssse021-lordsmail.esl",
  "ccbgssse031-advcyrus.bsa",
  "ccbgssse031-advcyrus.esm",
  "ccbgssse034-mntuni.bsa",
  "ccbgssse034-mntuni.esl",
  "ccbgssse035-petnhound.bsa",
  "ccbgssse035-petnhound.esl",
  "ccbgssse036-petbwolf.bsa",
  "ccbgssse036-petbwolf.esl",
  "ccbgssse038-bowofshadows.bsa",
  "ccbgssse038-bowofshadows.esl",
  "ccbgssse040-advobgobs.bsa",
  "ccbgssse040-advobgobs.esl",
  "ccbgssse041-netchleather.bsa",
  "ccbgssse041-netchleather.esl",
  "ccbgssse043-crosselv.bsa",
  "ccbgssse043-crosselv.esl",
  "ccbgssse045-hasedoki.bsa",
  "ccbgssse045-hasedoki.esl",
  "ccbgssse050-ba_daedric.bsa",
  "ccbgssse050-ba_daedric.esl",
  "ccbgssse051-ba_daedricmail.bsa",
  "ccbgssse051-ba_daedricmail.esl",
  "ccbgssse052-ba_iron.bsa",
  "ccbgssse052-ba_iron.esl",
  "ccbgssse053-ba_leather.bsa",
  "ccbgssse053-ba_leather.esl",
  "ccbgssse054-ba_orcish.bsa",
  "ccbgssse054-ba_orcish.esl",
  "ccbgssse055-ba_orcishscaled.bsa",
  "ccbgssse055-ba_orcishscaled.esl",
  "ccbgssse056-ba_silver.bsa",
  "ccbgssse056-ba_silver.esl",
  "ccbgssse057-ba_stalhrim.bsa",
  "ccbgssse057-ba_stalhrim.esl",
  "ccbgssse058-ba_steel.bsa",
  "ccbgssse058-ba_steel.esl",
  "ccbgssse059-ba_dragonplate.bsa",
  "ccbgssse059-ba_dragonplate.esl",
  "ccbgssse060-ba_dragonscale.bsa",
  "ccbgssse060-ba_dragonscale.esl",
  "ccbgssse061-ba_dwarven.bsa",
  "ccbgssse061-ba_dwarven.esl",
  "ccbgssse062-ba_dwarvenmail.bsa",
  "ccbgssse062-ba_dwarvenmail.esl",
  "ccbgssse063-ba_ebony.bsa",
  "ccbgssse063-ba_ebony.esl",
  "ccbgssse064-ba_elven.bsa",
  "ccbgssse064-ba_elven.esl",
  "ccbgssse066-staves.bsa",
  "ccbgssse066-staves.esl",
  "ccbgssse067-daedinv.bsa",
  "ccbgssse067-daedinv.esm",
  "ccbgssse068-bloodfall.bsa",
  "ccbgssse068-bloodfall.esl",
  "ccbgssse069-contest.bsa",
  "ccbgssse069-contest.esl",
  "cccbhsse001-gaunt.bsa",
  "cccbhsse001-gaunt.esl",
  "ccedhsse001-norjewel.bsa",
  "ccedhsse001-norjewel.esl",
  "ccedhsse002-splkntset.bsa",
  "ccedhsse002-splkntset.esl",
  "ccedhsse003-redguard.bsa",
  "ccedhsse003-redguard.esl",
  "cceejsse001-hstead.bsa",
  "cceejsse001-hstead.esm",
  "cceejsse002-tower.bsa",
  "cceejsse002-tower.esl",
  "cceejsse003-hollow.bsa",
  "cceejsse003-hollow.esl",
  "cceejsse004-hall.bsa",
  "cceejsse004-hall.esl",
  "cceejsse005-cave.bsa",
  "cceejsse005-cave.esm",
  "ccffbsse001-imperialdragon.bsa",
  "ccffbsse001-imperialdragon.esl",
  "ccffbsse002-crossbowpack.bsa",
  "ccffbsse002-crossbowpack.esl",
  "ccfsvsse001-backpacks.bsa",
  "ccfsvsse001-backpacks.esl",
  "cckrtsse001_altar.bsa",
  "cckrtsse001_altar.esl",
  "ccmtysse001-knightsofthenine.bsa",
  "ccmtysse001-knightsofthenine.esl",
  "ccmtysse002-ve.bsa",
  "ccmtysse002-ve.esl",
  "ccpewsse002-armsofchaos.bsa",
  "ccpewsse002-armsofchaos.esl",
  "ccqdrsse002-firewood.bsa",
  "ccqdrsse002-firewood.esl",
  "ccrmssse001-necrohouse.bsa",
  "ccrmssse001-necrohouse.esl",
  "cctwbsse001-puzzledungeon.bsa",
  "cctwbsse001-puzzledungeon.esm",
  "ccvsvsse001-winter.bsa",
  "ccvsvsse001-winter.esl",
  "ccvsvsse002-pets.bsa",
  "ccvsvsse002-pets.esl",
  "ccvsvsse003-necroarts.bsa",
  "ccvsvsse003-necroarts.esl",
  "ccvsvsse004-beafarmer.bsa",
  "ccvsvsse004-beafarmer.esl"
)

$CC_Installed = Get-ChildItem -Path ($InstallationPath + "Data") -Filter "cc*" | Select-Object -ExpandProperty Name

$CC_Comparison = Compare-Object -ReferenceObject $CC_Installed -DifferenceObject $CC_SkyrimAE

If ($CC_Comparison | Where-Object { $_.SideIndicator -eq "=>" } | Select-Object -ExpandProperty InputObject) {
  Write-Host ("You're missing the following CC;")
  foreach ($CC_Missing in $CC_Comparison) {
    if ($CC_Missing.SideIndicator -eq "=>") {
      Write-Host $CC_Missing.InputObject
    }
  }
  Write-Error "Please install the necessary Creation Club content." -Category NotInstalled; Exit
} Else {
  Write-Host "You're good to go!"
}
