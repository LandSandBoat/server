---------------------------
-- Magian Trial Objectives
---------------------------

-- This is a table of anon function for Magian Trial objectives/conditions.
-- Keyed by trial ID, if they return true, the trials progress is incremented and saved.

tpz = tpz or {}
tpz.magian = tpz.magian or {}

local checks = {}

-- Standard mob kill
-- params = { ["mob"] = mob }
checks.mobkill = function(self, player, params)
    if self.reqs.mobid and params.mob then
        return self.reqs.mobid[params.mob:getID()] and 1 or 0
    end
    return 0
end

tpz.magian.trials =
{
[   2] = {  -- Nocuous Weapon
        check = checks.mobkill,
        reqs = { mobid = set{ 17563801 } }
    },

[   3] = {  -- Black Triple Stars
        check = checks.mobkill,
        reqs = { mobid = set{ 17227972, 17227992 } }
    },

[   4] = {  -- Serra
        check = checks.mobkill,
        reqs = { mobid = set{ 16793646 } }
    },

[   5] = {  -- Bugbear Strongman
        check = checks.mobkill,
        reqs = { mobid = set{ 16822423, 16822427 } }
    },

[   6] = {  -- La Velue
        check = checks.mobkill,
        reqs = { mobid = set{ 17121576 } }
    },

[   7] = {  -- Hovering Hotpot
        check = checks.mobkill,
        reqs = { mobid = set{ 17596628 } }
    },

[   8] = {  -- Yacumama
        check = checks.mobkill,
        reqs = { mobid = set{ 17109384, 17113491} }
    },

[   9] = {  -- Feuerunke
        check = checks.mobkill,
        reqs = { mobid = set{ 17334552, 17338598 } }
    },

[1092] = {  -- Tammuz
        check = checks.mobkill,
        reqs = { mobid = set{ 17195484 } }
    },

[  68] = {  -- Tumbling Truffle
        check = checks.mobkill,
        reqs = { mobid = set{ 17195259 } }
    },

[  69] = {  -- Helldiver
        check = checks.mobkill,
        reqs = { mobid = set{ 17260907 } }
    },

[  70] = {  -- Orctrap
        check = checks.mobkill,
        reqs = { mobid = set{ 16785676 } }
    },

[  71] = {  -- Intulo
        check = checks.mobkill,
        reqs = { mobid = set{ 16793742 } }
    },

[  72] = {  -- Ramponneau
        check = checks.mobkill,
        reqs = { mobid = set{ 17166705 } }
    },

[  73] = {  -- Keeper of Halidom
        check = checks.mobkill,
        reqs = { mobid = set{ 17272978 } }
    },

[  74] = {  -- Shoggoth
        check = checks.mobkill,
        reqs = { mobid = set{ 17138077, 17146177 } }
    },

[  75] = {  -- Farruca Fly
        check = checks.mobkill,
        reqs = { mobid = set{ 17166769, 17174908 } }
    },

[1138] = {  -- Chesma
        check = checks.mobkill,
        reqs = { mobid = set{ 17195485 } }
    },

[ 150] = {  -- Serpopard Ishtar
        check = checks.mobkill,
        reqs = { mobid = set{ 17256563, 17256690 } }
    },

[ 151] = {  -- Tottering Toby
        check = checks.mobkill,
        reqs = { mobid = set{ 17207476 } }
    },

[ 152] = {  -- Drooling Daisy
        check = checks.mobkill,
        reqs = { mobid = set{ 17228236 } }
    },

[ 153] = {  -- Gargantua
        check = checks.mobkill,
        reqs = { mobid = set{ 17232079 } }
    },

[ 154] = {  -- Megalobugard
        check = checks.mobkill,
        reqs = { mobid = set{ 16875741 } }
    },

[ 155] = {  -- Ratatoskr
        check = checks.mobkill,
        reqs = { mobid = set{ 17170475 } }
    },

[ 156] = {  -- Jyeshtha
        check = checks.mobkill,
        reqs = { mobid = set{ 17174909, 17166770 } }
    },

[ 157] = {  -- Capricornus
        check = checks.mobkill,
        reqs = { mobid = set{ 17109385, 17113492 } }
    },

[1200] = {  -- Tammuz
        check = checks.mobkill,
        reqs = { mobid = set{ 17195484 } }
    },

[ 216] = {  -- Bloodpool Vorax
        check = checks.mobkill,
        reqs = { mobid = set{ 17224019 } }
    },

[ 217] = {  -- Golden Bat
        check = checks.mobkill,
        reqs = { mobid = set{ 17199564 } }
    },

[ 218] = {  -- Slippery Sucker
        check = checks.mobkill,
        reqs = { mobid = set{ 17293389 } }
    },

[ 219] = {  -- Seww the Squidlimbed
        check = checks.mobkill,
        reqs = { mobid = set{ 17498301 } }
    },

[ 220] = {  -- Ankabut
        check = checks.mobkill,
        reqs = { mobid = set{ 17137705 } }
    },

[ 221] = {  -- Okyupete
        check = checks.mobkill,
        reqs = { mobid = set{ 16879847 } }
    },

[ 222] = {  -- Urd
        check = checks.mobkill,
        reqs = { mobid = set{ 17178923 } }
    },

[ 223] = {  -- Lamprey Lord
        check = checks.mobkill,
        reqs = { mobid = set{ 17138078, 17146178 } }
    },

[1246] = {  -- Chesma
        check = checks.mobkill,
        reqs = { mobid = set{ 17195485 } }
    },

[ 282] = {  -- Panzer Percival
        check = checks.mobkill,
        reqs = { mobid = set{ 17203585, 17203642 } }
    },

[ 283] = {  -- Ge'Dha Evileye
        check = checks.mobkill,
        reqs = { mobid = set{ 17379450 } }
    },

[ 284] = {  -- Bashe
        check = checks.mobkill,
        reqs = { mobid = set{ 17268788 } }
    },

[ 285] = {  -- Intulo
        check = checks.mobkill,
        reqs = { mobid = set{ 16793742 } }
    },

[ 286] = {  -- Ramponneau
        check = checks.mobkill,
        reqs = { mobid = set{ 17166705 } }
    },

[ 287] = {  -- Keeper of Halidom
        check = checks.mobkill,
        reqs = { mobid = set{ 17272978 } }
    },

[ 288] = {  -- Shoggoth
        check = checks.mobkill,
        reqs = { mobid = set{ 17138077, 17146177 } }
    },

[ 289] = {  -- Farruca Fly
        check = checks.mobkill,
        reqs = { mobid = set{ 17166769, 17174908 } }
    },

[1293] = {  -- Tammuz
        check = checks.mobkill,
        reqs = { mobid = set{ 17195484 } }
    },

[ 364] = {  -- Hoo Mjuu the Torrent
        check = checks.mobkill,
        reqs = { mobid = set{ 17371515 } }
    },

[ 365] = {  -- Daggerclaw Dracos
        check = checks.mobkill,
        reqs = { mobid = set{ 17264818 } }
    },

[ 366] = {  -- Namtar
        check = checks.mobkill,
        reqs = { mobid = set{ 17498184 } }
    },

[ 367] = {  -- Gargantua
        check = checks.mobkill,
        reqs = { mobid = set{ 17232079 } }
    },

[ 368] = {  -- Megalobugard
        check = checks.mobkill,
        reqs = { mobid = set{ 16875741 } }
    },

[ 369] = {  -- Ratatoskr
        check = checks.mobkill,
        reqs = { mobid = set{ 17170475 } }
    },

[ 370] = {  -- Jyeshtha
        check = checks.mobkill,
        reqs = { mobid = set{ 17174909, 17166770 } }
    },

[ 371] = {  -- Capricornus
        check = checks.mobkill,
        reqs = { mobid = set{ 17109385, 17113492 } }
    },

[1354] = {  -- Chesma
        check = checks.mobkill,
        reqs = { mobid = set{ 17195485 } }
    },

[ 512] = {  -- Barbastelle
        check = checks.mobkill,
        reqs = { mobid = set{ 17555721 } }
    },

[ 513] = {  -- Ah Puch
        check = checks.mobkill,
        reqs = { mobid = set{ 17571903 } }
    },

[ 514] = {  -- Donggu
        check = checks.mobkill,
        reqs = { mobid = set{ 17567801 } }
    },

[ 515] = {  -- Bugbear Strongman
        check = checks.mobkill,
        reqs = { mobid = set{ 16822423, 16822427 } }
    },

[ 516] = {  -- La Velue
        check = checks.mobkill,
        reqs = { mobid = set{ 17121576 } }
    },

[ 517] = {  -- Hovering Hotpot
        check = checks.mobkill,
        reqs = { mobid = set{ 17596628 } }
    },

[ 518] = {  -- Yacumama
        check = checks.mobkill,
        reqs = { mobid = set{ 17109384, 17113491 } }
    },

[ 519] = {  -- Feuerunke
        check = checks.mobkill,
        reqs = { mobid = set{ 17334552, 17338598 } }
    },

[1462] = {  -- Tammuz
        check = checks.mobkill,
        reqs = { mobid = set{ 17195484 } }
    },

[ 430] = {  -- Slendlix Spindlethumb
        check = checks.mobkill,
        reqs = { mobid = set{ 17563785 } }
    },

[ 431] = {  -- Herbage Hunter
        check = checks.mobkill,
        reqs = { mobid = set{ 17256836 } }
    },

[ 432] = {  -- Kirata
        check = checks.mobkill,
        reqs = { mobid = set{ 17232044 } }
    },

[ 433] = {  -- Intulo
        check = checks.mobkill,
        reqs = { mobid = set{ 16793742 } }
    },

[ 434] = {  -- Ramponneau
        check = checks.mobkill,
        reqs = { mobid = set{ 17166705 } }
    },

[ 435] = {  -- Keeper of Halidom
        check = checks.mobkill,
        reqs = { mobid = set{ 17272978 } }
    },

[ 436] = {  -- Shoggoth
        check = checks.mobkill,
        reqs = { mobid = set{ 17138077, 17146177 } }
    },

[ 437] = {  -- Farruca Fly
        check = checks.mobkill,
        reqs = { mobid = set{ 17166769, 17174908 } }
    },

[1400] = {  -- Chesma
        check = checks.mobkill,
        reqs = { mobid = set{ 17195485 } }
    },

[ 578] = {  -- Zi'Ghi Boneeater
        check = checks.mobkill,
        reqs = { mobid = set{ 17363208 } }
    },

[ 579] = {  -- Lumbering Lambert
        check = checks.mobkill,
        reqs = { mobid = set{ 17195317 } }
    },

[ 580] = {  -- Deadly Dodo
        check = checks.mobkill,
        reqs = { mobid = set{ 17268851 } }
    },

[ 581] = {  -- Gargantua
        check = checks.mobkill,
        reqs = { mobid = set{ 17232079 } }
    },

[ 582] = {  -- Megalobugard
        check = checks.mobkill,
        reqs = { mobid = set{ 16875741 } }
    },

[ 583] = {  -- Ratatoskr
        check = checks.mobkill,
        reqs = { mobid = set{ 17170475 } }
    },

[ 584] = {  -- Jyeshtha
        check = checks.mobkill,
        reqs = { mobid = set{ 17174909, 17166770 } }
    },

[ 585] = {  -- Capricornus
        check = checks.mobkill,
        reqs = { mobid = set{ 17109385, 17113492 } }
    },

[1508] = {  -- Tammuz
        check = checks.mobkill,
        reqs = { mobid = set{ 17195484 } }
    },

[ 644] = {  -- Vuu Puqu the Beguiler
        check = checks.mobkill,
        reqs = { mobid = set{ 17371578 } }
    },

[ 645] = {  -- Buburimboo
        check = checks.mobkill,
        reqs = { mobid = set{ 17261003 } }
    },

[ 646] = {  -- Zo'Khu Blackcloud
        check = checks.mobkill,
        reqs = { mobid = set{ 17379564 } }
    },

[ 647] = {  -- Seww the Squidlimbed
        check = checks.mobkill,
        reqs = { mobid = set{ 17498301 } }
    },

[ 648] = {  -- Ankabut
        check = checks.mobkill,
        reqs = { mobid = set{ 17137705 } }
    },

[ 649] = {  -- Okyupete
        check = checks.mobkill,
        reqs = { mobid = set{ 16879847 } }
    },

[ 650] = {  -- Urd
        check = checks.mobkill,
        reqs = { mobid = set{ 17178923 } }
    },

[ 651] = {  -- Lamprey Lord
        check = checks.mobkill,
        reqs = { mobid = set{ 17138078, 17146178 } }
    },

[1554] = {  -- Chesma
        check = checks.mobkill,
        reqs = { mobid = set{ 17195485 } }
    },

[ 710] = {  -- Stray Mary
        check = checks.mobkill,
        reqs = { mobid = set{ 17219795, 17219933 } }
    },

[ 711] = {  -- Hawkeyed Dnatbat
        check = checks.mobkill,
        reqs = { mobid = set{ 17387567 } }
    },

[ 712] = {  -- Dune Widow
        check = checks.mobkill,
        reqs = { mobid = set{ 17244396 } }
    },

[ 713] = {  -- Seww the Squidlimbed
        check = checks.mobkill,
        reqs = { mobid = set{ 17498301 } }
    },

[ 714] = {  -- Ankabut
        check = checks.mobkill,
        reqs = { mobid = set{ 17137705 } }
    },

[ 715] = {  -- Okyupete
        check = checks.mobkill,
        reqs = { mobid = set{ 16879847 } }
    },

[ 716] = {  -- Urd
        check = checks.mobkill,
        reqs = { mobid = set{ 17178923 } }
    },

[ 717] = {  -- Lamprey Lord
        check = checks.mobkill,
        reqs = { mobid = set{ 17138078, 17146178 } }
    },

[1600] = {  -- Chesma
        check = checks.mobkill,
        reqs = { mobid = set{ 17195485 } }
    },

[ 776] = {  -- Teporingo
        check = checks.mobkill,
        reqs = { mobid = set{ 17559584 } }
    },

[ 777] = {  -- Valkurm Emperor
        check = checks.mobkill,
        reqs = { mobid = set{ 17199438 } }
    },

[ 778] = {  -- Hyakume
        check = checks.mobkill,
        reqs = { mobid = set{ 17457236 } }
    },

[ 779] = {  -- Gloomanita
        check = checks.mobkill,
        reqs = { mobid = set{ 17137821 } }
    },

[ 780] = {  -- Mischievous Micholas
        check = checks.mobkill,
        reqs = { mobid = set{ 17281149 } }
    },

[ 781] = {  -- Cactuar Cantautor
        check = checks.mobkill,
        reqs = { mobid = set{ 17289560 } }
    },

[ 782] = {  -- Erebus
        check = checks.mobkill,
        reqs = { mobid = set{ 17334553, 17338599 } }
    },

[ 783] = {  -- Skuld
        check = checks.mobkill,
        reqs = { mobid = set{ 17178924 } }
    },

[1646] = {  -- Chesma
        check = checks.mobkill,
        reqs = { mobid = set{ 17195485 } }
    },

[ 941] = {  -- Be'Hya Hundredwall
        check = checks.mobkill,
        reqs = { mobid = set{ 17363258 } }
    },

[ 942] = {  -- Jolly Green
        check = checks.mobkill,
        reqs = { mobid = set{ 17092898 } }
    },

[ 943] = {  -- Trembler Tabitha
        check = checks.mobkill,
        reqs = { mobid = set{ 17588278 } }
    },

[ 944] = {  -- Seww the Squidlimbed
        check = checks.mobkill,
        reqs = { mobid = set{ 17498301 } }
    },

[ 945] = {  -- Ankabut
        check = checks.mobkill,
        reqs = { mobid = set{ 17137705 } }
    },

[ 946] = {  -- Okyupete
        check = checks.mobkill,
        reqs = { mobid = set{ 16879847 } }
    },

[ 947] = {  -- Urd
        check = checks.mobkill,
        reqs = { mobid = set{ 17178923 } }
    },

[ 948] = {  -- Lamprey Lord
        check = checks.mobkill,
        reqs = { mobid = set{ 17138078, 17146178 } }
    },

[1788] = {  -- Chesma
        check = checks.mobkill,
        reqs = { mobid = set{ 17195485 } }
    },

[ 891] = {  -- Desmodont
        check = checks.mobkill,
        reqs = { mobid = set{ 17571870 } }
    },

[ 892] = {  -- Moo Ouzi the Swiftblade
        check = checks.mobkill,
        reqs = { mobid = set{ 17395816 } }
    },

[ 893] = {  -- Ni'Zho Bladebender
        check = checks.mobkill,
        reqs = { mobid = set{ 17223797 } }
    },

[ 894] = {  -- Bugbear Strongman
        check = checks.mobkill,
        reqs = { mobid = set{ 16822423, 16822427 } }
    },

[ 895] = {  -- La Velue
        check = checks.mobkill,
        reqs = { mobid = set{ 17121576 } }
    },

[ 896] = {  -- Hovering Hotpot
        check = checks.mobkill,
        reqs = { mobid = set{ 17596628 } }
    },

[ 897] = {  -- Yacumama
        check = checks.mobkill,
        reqs = { mobid = set{ 17109384, 17113491 } }
    },

[ 898] = {  -- Feuerunke
        check = checks.mobkill,
        reqs = { mobid = set{ 17334552, 17338598 } }
    },

[1758] = {  -- Tammuz
        check = checks.mobkill,
        reqs = { mobid = set{ 17195484 } }
    },
}
