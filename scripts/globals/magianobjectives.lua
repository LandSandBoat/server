---------------------------
-- Magian Trial Objectives
---------------------------

-- This is a table of anon function for Magian Trial objectives/conditions.
-- Keyed by trial ID, if they return true, the trials progress is incremented and saved.

tpz = tpz or {}
tpz.magian = tpz.magian or {}

tpz.magian.objectives =
{
[   2] = function (player, conditions)
           return conditions.mob and conditions.mob:getID() == 17563801 -- Nocuous Weapon
       end,

[   3] = function (player, conditions)
           return conditions.mob and (conditions.mob:getID() == 17227972 or conditions.mob:getID() == 17227992) -- Black Triple Stars
       end,

[   4] = function (player, conditions)
           return conditions.mob and conditions.mob:getID() == 16793646 -- Serra
       end,

[   5] = function (player, conditions)
           return conditions.mob and (conditions.mob:getID() == 16822423 or conditions.mob:getID() == 16822427) -- Bugbear Strongman
       end,

[   6] = function (player, conditions)
           return conditions.mob and conditions.mob:getID() == 17121576 -- La Velue
       end,

[   7] = function (player, conditions)
           return conditions.mob and conditions.mob:getID() == 17596628 -- Hovering Hotpot
       end,

[   8] = function (player, conditions)
           return conditions.mob and (conditions.mob:getID() == 17191325 or conditions.mob:getID() == 17109384 or conditions.mob:getID() == 17113491) -- Yacumama
       end,

[   9] = function (player, conditions)
           return conditions.mob and (conditions.mob:getID() == 17334552 or conditions.mob:getID() == 17338598) -- Feuerunke
       end,

[1092] = function (player, conditions)
           return conditions.mob and (conditions.mob:getID() == 17195484) -- Tammuz
       end,

[  68] = function (player, conditions)
           return conditions.mob and conditions.mob:getID() == 17195259 -- Tumbling Truffle
       end,

[  69] = function (player, conditions)
           return conditions.mob and conditions.mob:getID() == 17260907 -- Helldiver
       end,

[  70] = function (player, conditions)
           return conditions.mob and conditions.mob:getID() == 16785676 -- Orctrap
       end,

[  71] = function (player, conditions)
           return conditions.mob and conditions.mob:getID() == 16793742 -- Intulo
       end,

[  72] = function (player, conditions)
           return conditions.mob and conditions.mob:getID() == 17166705 -- Ramponneau
       end,

[  73] = function (player, conditions)
           return conditions.mob and conditions.mob:getID() == 17272978 -- Keeper of Halidom
       end,

[  74] = function (player, conditions)
           return conditions.mob and (conditions.mob:getID() == 17138077 or conditions.mob:getID() == 17146177) -- Shoggoth
       end,

[  75] = function (player, conditions)
           return conditions.mob and (conditions.mob:getID() == 17166769 or conditions.mob:getID() == 17174908) -- Farruca Fly
       end,

[1138] = function (player, conditions)
           return conditions.mob and (conditions.mob:getID() == 17195485) -- Chesma
       end,

[ 150] = function (player, conditions)
           return conditions.mob and (conditions.mob:getID() == 17256563 or conditions.mob:getID() == 17256690) -- Serpopard Ishtar
       end,

[ 151] = function (player, conditions)
           return conditions.mob and conditions.mob:getID() == 17207476 -- Tottering Toby
       end,

[ 152] = function (player, conditions)
           return conditions.mob and conditions.mob:getID() == 17228236 -- Drooling Daisy
       end,

[ 153] = function (player, conditions)
           return conditions.mob and conditions.mob:getID() == 17232079 -- Gargantua
       end,

[ 154] = function (player, conditions)
           return conditions.mob and conditions.mob:getID() == 16875741 -- Megalobugard
       end,

[ 155] = function (player, conditions)
           return conditions.mob and conditions.mob:getID() == 17170475 -- Ratatoskr
       end,

[ 156] = function (player, conditions)
           return conditions.mob and (conditions.mob:getID() == 17174909 or conditions.mob:getID() == 17166770) -- Jyeshtha
       end,

[ 157] = function (player, conditions)
           return conditions.mob and (conditions.mob:getID() == 17191326 or conditions.mob:getID() == 17109385 or conditions.mob:getID() == 17113492) -- Capricornus
       end,

[1200] = function (player, conditions)
           return conditions.mob and (conditions.mob:getID() == 17195484) -- Tammuz
       end,

[ 216] = function (player, conditions)
           return conditions.mob and conditions.mob:getID() == 17224019 -- Bloodpool Vorax
       end,

[ 217] = function (player, conditions)
           return conditions.mob and conditions.mob:getID() == 17199564 -- Golden Bat
       end,

[ 218] = function (player, conditions)
           return conditions.mob and conditions.mob:getID() == 17293389 -- Slippery Sucker
       end,

[ 219] = function (player, conditions)
           return conditions.mob and conditions.mob:getID() == 17498301 -- Seww the Squidlimbed
       end,

[ 220] = function (player, conditions)
           return conditions.mob and conditions.mob:getID() == 17137705 -- Ankabut
       end,

[ 221] = function (player, conditions)
           return conditions.mob and conditions.mob:getID() == 16879847 -- Okyupete
       end,

[ 222] = function (player, conditions)
           return conditions.mob and conditions.mob:getID() == 17178923 -- Urd
       end,

[ 223] = function (player, conditions)
           return conditions.mob and (conditions.mob:getID() == 17138078 or conditions.mob:getID() == 17146178) -- Lamprey Lord
       end,

[1246] = function (player, conditions)
           return conditions.mob and (conditions.mob:getID() == 17195485) -- Chesma
       end,

[ 282] = function (player, conditions)
           return conditions.mob and (conditions.mob:getID() == 17203585 or conditions.mob:getID() == 17203642) -- Panzer Percival
       end,

[ 283] = function (player, conditions)
           return conditions.mob and conditions.mob:getID() == 17379450 -- Ge'Dha Evileye
       end,

[ 284] = function (player, conditions)
           return conditions.mob and conditions.mob:getID() == 17268788 -- Bashe
       end,

[ 285] = function (player, conditions)
           return conditions.mob and conditions.mob:getID() == 16793742 -- Intulo
       end,

[ 286] = function (player, conditions)
           return conditions.mob and conditions.mob:getID() == 17166705 -- Ramponneau
       end,

[ 287] = function (player, conditions)
           return conditions.mob and conditions.mob:getID() == 17272978 -- Keeper of Halidom
       end,

[ 288] = function (player, conditions)
           return conditions.mob and (conditions.mob:getID() == 17138077 or conditions.mob:getID() == 17146177) -- Shoggoth
       end,

[ 289] = function (player, conditions)
           return conditions.mob and (conditions.mob:getID() == 17166769 or conditions.mob:getID() == 17174908) -- Farruca Fly
       end,

[1293] = function (player, conditions)
           return conditions.mob and (conditions.mob:getID() == 17195484) -- Tammuz
       end,

[ 364] = function (player, conditions)
           return conditions.mob and conditions.mob:getID() == 17371515 -- Hoo Mjuu the Torrent
       end,

[ 365] = function (player, conditions)
           return conditions.mob and conditions.mob:getID() == 17264818 -- Daggerclaw Dracos
       end,

[ 366] = function (player, conditions)
           return conditions.mob and conditions.mob:getID() == 17498184 -- Namtar
       end,

[ 367] = function (player, conditions)
           return conditions.mob and conditions.mob:getID() == 17232079 -- Gargantua
       end,

[ 368] = function (player, conditions)
           return conditions.mob and conditions.mob:getID() == 16875741 -- Megalobugard
       end,

[ 369] = function (player, conditions)
           return conditions.mob and conditions.mob:getID() == 17170475 -- Ratatoskr
       end,

[ 370] = function (player, conditions)
           return conditions.mob and (conditions.mob:getID() == 17174909 or conditions.mob:getID() == 17166770) -- Jyeshtha
       end,

[ 371] = function (player, conditions)
           return conditions.mob and (conditions.mob:getID() == 17191326 or conditions.mob:getID() == 17109385 or conditions.mob:getID() == 17113492) -- Capricornus
       end,

[1354] = function (player, conditions)
           return conditions.mob and (conditions.mob:getID() == 17195485) -- Chesma
       end,

[ 512] = function (player, conditions)
           return conditions.mob and conditions.mob:getID() == 17555721 -- Barbastelle
       end,

[ 513] = function (player, conditions)
           return conditions.mob and conditions.mob:getID() == 17571903 -- Ah Puch
       end,

[ 514] = function (player, conditions)
           return conditions.mob and conditions.mob:getID() == 17567801 -- Donggu
       end,

[ 515] = function (player, conditions)
           return conditions.mob and (conditions.mob:getID() == 16822423 or conditions.mob:getID() == 16822427) -- Bugbear Strongman
       end,

[ 516] = function (player, conditions)
           return conditions.mob and conditions.mob:getID() == 17121576 -- La Velue
       end,

[ 517] = function (player, conditions)
           return conditions.mob and conditions.mob:getID() == 17596628 -- Hovering Hotpot
       end,

[ 518] = function (player, conditions)
           return conditions.mob and (conditions.mob:getID() == 17191325 or conditions.mob:getID() == 17109384 or conditions.mob:getID() == 17113491) -- Yacumama
       end,

[ 519] = function (player, conditions)
           return conditions.mob and (conditions.mob:getID() == 17334552 or conditions.mob:getID() == 17338598) -- Feuerunke
       end,

[1462] = function (player, conditions)
           return conditions.mob and (conditions.mob:getID() == 17195484) -- Tammuz
       end,

[ 430] = function (player, conditions)
           return conditions.mob and conditions.mob:getID() == 17563785 -- Slendlix Spindlethumb
       end,

[ 431] = function (player, conditions)
           return conditions.mob and conditions.mob:getID() == 17256836 -- Herbage Hunter
       end,

[ 432] = function (player, conditions)
           return conditions.mob and conditions.mob:getID() == 17232044 -- Kirata
       end,

[ 433] = function (player, conditions)
           return conditions.mob and conditions.mob:getID() == 16793742 -- Intulo
       end,

[ 434] = function (player, conditions)
           return conditions.mob and conditions.mob:getID() == 17166705 -- Ramponneau
       end,

[ 435] = function (player, conditions)
           return conditions.mob and conditions.mob:getID() == 17272978 -- Keeper of Halidom
       end,

[ 436] = function (player, conditions)
           return conditions.mob and (conditions.mob:getID() == 17138077 or conditions.mob:getID() == 17146177) -- Shoggoth
       end,

[ 437] = function (player, conditions)
           return conditions.mob and (conditions.mob:getID() == 17166769 or conditions.mob:getID() == 17174908) -- Farruca Fly
       end,

[1400] = function (player, conditions)
           return conditions.mob and (conditions.mob:getID() == 17195485) -- Chesma
       end,

[ 578] = function (player, conditions)
           return conditions.mob and conditions.mob:getID() == 17363208 -- Zi'Ghi Boneeater
       end,

[ 579] = function (player, conditions)
           return conditions.mob and conditions.mob:getID() == 17195317 -- Lumbering Lambert
       end,

[ 580] = function (player, conditions)
           return conditions.mob and conditions.mob:getID() == 17268851 -- Deadly Dodo
       end,

[ 581] = function (player, conditions)
           return conditions.mob and conditions.mob:getID() == 17232079 -- Gargantua
       end,

[ 582] = function (player, conditions)
           return conditions.mob and conditions.mob:getID() == 16875741 -- Megalobugard
       end,

[ 583] = function (player, conditions)
           return conditions.mob and conditions.mob:getID() == 17170475 -- Ratatoskr
       end,

[ 584] = function (player, conditions)
           return conditions.mob and (conditions.mob:getID() == 17174909 or conditions.mob:getID() == 17166770) -- Jyeshtha
       end,

[ 585] = function (player, conditions)
           return conditions.mob and (conditions.mob:getID() == 17191326 or conditions.mob:getID() == 17109385 or conditions.mob:getID() == 17113492) -- Capricornus
       end,

[1508] = function (player, conditions)
           return conditions.mob and (conditions.mob:getID() == 17195484) -- Tammuz
       end,

[ 644] = function (player, conditions)
           return conditions.mob and conditions.mob:getID() == 17371578 -- Vuu Puqu the Beguiler
       end,

[ 645] = function (player, conditions)
           return conditions.mob and conditions.mob:getID() == 17261003 -- Buburimboo
       end,

[ 646] = function (player, conditions)
           return conditions.mob and conditions.mob:getID() == 17379564 -- Zo'Khu Blackcloud
       end,

[ 647] = function (player, conditions)
           return conditions.mob and conditions.mob:getID() == 17498301 -- Seww the Squidlimbed
       end,

[ 648] = function (player, conditions)
           return conditions.mob and conditions.mob:getID() == 17137705 -- Ankabut
       end,

[ 649] = function (player, conditions)
           return conditions.mob and conditions.mob:getID() == 16879847 -- Okyupete
       end,

[ 650] = function (player, conditions)
           return conditions.mob and conditions.mob:getID() == 17178923 -- Urd
       end,

[ 651] = function (player, conditions)
           return conditions.mob and (conditions.mob:getID() == 17138078 or conditions.mob:getID() == 17146178) -- Lamprey Lord
       end,

[1554] = function (player, conditions)
           return conditions.mob and (conditions.mob:getID() == 17195485) -- Chesma
       end,

[ 710] = function (player, conditions)
           return conditions.mob and (conditions.mob:getID() == 17219795 or conditions.mob:getID() == 17219933) -- Stray Mary
       end,

[ 711] = function (player, conditions)
           return conditions.mob and conditions.mob:getID() == 17387567 -- Hawkeyed Dnatbat
       end,

[ 712] = function (player, conditions)
           return conditions.mob and conditions.mob:getID() == 17244396 -- Dune Widow
       end,

[ 713] = function (player, conditions)
           return conditions.mob and conditions.mob:getID() == 17498301 -- Seww the Squidlimbed
       end,

[ 714] = function (player, conditions)
           return conditions.mob and conditions.mob:getID() == 17137705 -- Ankabut
       end,

[ 715] = function (player, conditions)
           return conditions.mob and conditions.mob:getID() == 16879847 -- Okyupete
       end,

[ 716] = function (player, conditions)
           return conditions.mob and conditions.mob:getID() == 17178923 -- Urd
       end,

[ 717] = function (player, conditions)
           return conditions.mob and (conditions.mob:getID() == 17138078 or conditions.mob:getID() == 17146178) -- Lamprey Lord
       end,

[1600] = function (player, conditions)
           return conditions.mob and (conditions.mob:getID() == 17195485) -- Chesma
       end,

[ 776] = function (player, conditions)
           return conditions.mob and conditions.mob:getID() == 17559584 -- Teporingo
       end,

[ 777] = function (player, conditions)
           return conditions.mob and conditions.mob:getID() == 17199438 -- Valkurm Emperor
       end,

[ 778] = function (player, conditions)
           return conditions.mob and conditions.mob:getID() == 17457236 -- Hyakume
       end,

[ 779] = function (player, conditions)
           return conditions.mob and conditions.mob:getID() == 17137821 -- Gloomanita
       end,

[ 780] = function (player, conditions)
           return conditions.mob and conditions.mob:getID() == 17281149 -- Mischievous Micholas
       end,

[ 781] = function (player, conditions)
           return conditions.mob and conditions.mob:getID() == 17289560 -- Cactuar Cantautor
       end,

[ 782] = function (player, conditions)
           return conditions.mob and (conditions.mob:getID() == 17334553 or conditions.mob:getID() == 17338599) -- Erebus
       end,

[ 783] = function (player, conditions)
           return conditions.mob and (conditions.mob:getID() == 17178924) -- Skuld
       end,

[1646] = function (player, conditions)
           return conditions.mob and (conditions.mob:getID() == 17195485) -- Chesma
       end,

[ 941] = function (player, conditions)
           return conditions.mob and conditions.mob:getID() == 17363258 -- Be'Hya Hundredwall
       end,

[ 942] = function (player, conditions)
           return conditions.mob and conditions.mob:getID() == 17092898 -- Jolly Green
       end,

[ 943] = function (player, conditions)
           return conditions.mob and conditions.mob:getID() == 17588278 -- Trembler Tabitha
       end,

[ 944] = function (player, conditions)
           return conditions.mob and conditions.mob:getID() == 17498301 -- Seww the Squidlimbed
       end,

[ 945] = function (player, conditions)
           return conditions.mob and conditions.mob:getID() == 17137705 -- Ankabut
       end,

[ 946] = function (player, conditions)
           return conditions.mob and conditions.mob:getID() == 16879847 -- Okyupete
       end,

[ 947] = function (player, conditions)
           return conditions.mob and conditions.mob:getID() == 17178923 -- Urd
       end,

[ 948] = function (player, conditions)
           return conditions.mob and (conditions.mob:getID() == 17138078 or conditions.mob:getID() == 17146178) -- Lamprey Lord
       end,

[1788] = function (player, conditions)
           return conditions.mob and (conditions.mob:getID() == 17195485) -- Chesma
       end,

[ 891] = function (player, conditions)
           return conditions.mob and conditions.mob:getID() == 17571870 -- Desmodont
       end,

[ 892] = function (player, conditions)
           return conditions.mob and conditions.mob:getID() == 17395816 -- Moo Ouzi the Swiftblade
       end,

[ 893] = function (player, conditions)
           return conditions.mob and conditions.mob:getID() == 17223797 -- Ni'Zho Bladebender
       end,

[ 894] = function (player, conditions)
           return conditions.mob and (conditions.mob:getID() == 16822423 or conditions.mob:getID() == 16822427) -- Bugbear Strongman
       end,

[ 895] = function (player, conditions)
           return conditions.mob and conditions.mob:getID() == 17121576 -- La Velue
       end,

[ 896] = function (player, conditions)
           return conditions.mob and conditions.mob:getID() == 17596628 -- Hovering Hotpot
       end,

[ 897] = function (player, conditions)
           return conditions.mob and (conditions.mob:getID() == 17191325 or conditions.mob:getID() == 17109384 or conditions.mob:getID() == 17113491) -- Yacumama
       end,

[ 898] = function (player, conditions)
           return conditions.mob and (conditions.mob:getID() == 17334552 or conditions.mob:getID() == 17338598) -- Feuerunke
       end,

[1758] = function (player, conditions)
           return conditions.mob and (conditions.mob:getID() == 17195484) -- Tammuz
       end,
}
