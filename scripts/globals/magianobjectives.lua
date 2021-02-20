-----------------------------------
-- Magian Trial Objectives
-----------------------------------
require("scripts/globals/common")
-----------------------------------

-- This is a table of anon function for Magian Trial objectives/conditions.
-- Keyed by trial ID, if they return true, the trials progress is incremented and saved.

tpz = tpz or {}
tpz.magian = tpz.magian or {}
local checks = {}

checks.checkMobKill = function(reqs, params)
    return reqs.mobid and params.mob and reqs.mobid[params.mob:getID()] and 1 or 0
end

checks.checkWsOnMobsystem = function(reqs, params)
    return reqs.mobSystem and params.mob and reqs.wSkill and reqs.mobSystem[params.mob:getSystem()] and reqs.wSkill[params.wSkillId] and 1 or 0
end

checks.checkWsKill = function(reqs, params)
    return reqs.mobSystem and params.mob and reqs.wSkill and reqs.mobSystem[params.mob:getSystem()] and reqs.wSkill[params.wSkillId] and params.mob:isDead() and 1 or 0
end

checks.checkTrials = function(self, player, params)
    local ismobkill = checks.checkMobKill(self.reqs, params)
    if params.triggerWs then
        if self.reqs.killWithWs then
            return checks.checkWsKill(self.reqs, params)
        else
            return checks.checkWsOnMobsystem(self.reqs, params)
        end
    else
        return ismobkill
    end
    return 0
end

checks.checkTradeTrials = function(self, player, params)
    return self.reqs.itemId[params.itemId] ~= nil and params.quantity or 0
end

tpz.magian.trials =
{
[   2] = { check = checks.checkTrials, reqs = { mobid = set{ 17563801 } } }, -- Nocuous Weapon
[   3] = { check = checks.checkTrials, reqs = { mobid = set{ 17227972, 17227992 } } }, -- Black Triple Stars
[   4] = { check = checks.checkTrials, reqs = { mobid = set{ 16793646 } } }, -- Serra
[   5] = { check = checks.checkTrials, reqs = { mobid = set{ 16822423, 16822427 } } }, -- Bugbear Strongman
[   6] = { check = checks.checkTrials, reqs = { mobid = set{ 17121576 } } }, -- La Velue
[   7] = { check = checks.checkTrials, reqs = { mobid = set{ 17596628 } } }, -- Hovering Hotpot
[   8] = { check = checks.checkTrials, reqs = { mobid = set{ 17109384, 17113491} } }, -- Yacumama
[   9] = { check = checks.checkTrials, reqs = { mobid = set{ 17334552, 17338598 } } }, -- Feuerunke
[1092] = { check = checks.checkTrials, reqs = { mobid = set{ 17195484 } } }, -- Tammuz
[  68] = { check = checks.checkTrials, reqs = { mobid = set{ 17195259 } } }, -- Tumbling Truffle
[  69] = { check = checks.checkTrials, reqs = { mobid = set{ 17260907 } } }, -- Helldiver
[  70] = { check = checks.checkTrials, reqs = { mobid = set{ 16785676 } } }, -- Orctrap
[  71] = { check = checks.checkTrials, reqs = { mobid = set{ 16793742 } } }, -- Intulo
[  72] = { check = checks.checkTrials, reqs = { mobid = set{ 17166705 } } }, -- Ramponneau
[  73] = { check = checks.checkTrials, reqs = { mobid = set{ 17272978 } } }, -- Keeper of Halidom
[  74] = { check = checks.checkTrials, reqs = { mobid = set{ 17138077, 17146177 } } }, -- Shoggoth
[  75] = { check = checks.checkTrials, reqs = { mobid = set{ 17166769, 17174908 } } }, -- Farruca Fly
[1138] = { check = checks.checkTrials, reqs = { mobid = set{ 17195485 } } }, -- Chesma
[ 150] = { check = checks.checkTrials, reqs = { mobid = set{ 17256563, 17256690 } } }, -- Serpopard Ishtar
[ 151] = { check = checks.checkTrials, reqs = { mobid = set{ 17207476 } } }, -- Tottering Toby
[ 152] = { check = checks.checkTrials, reqs = { mobid = set{ 17228236 } } }, -- Drooling Daisy
[ 153] = { check = checks.checkTrials, reqs = { mobid = set{ 17232079 } } }, -- Gargantua
[ 154] = { check = checks.checkTrials, reqs = { mobid = set{ 16875741 } } }, -- Megalobugard
[ 155] = { check = checks.checkTrials, reqs = { mobid = set{ 17170475 } } }, -- Ratatoskr
[ 156] = { check = checks.checkTrials, reqs = { mobid = set{ 17174909, 17166770 } } }, -- Jyeshtha
[ 157] = { check = checks.checkTrials, reqs = { mobid = set{ 17109385, 17113492 } } }, -- Capricornus
[1200] = { check = checks.checkTrials, reqs = { mobid = set{ 17195484 } } }, -- Tammuz
[ 216] = { check = checks.checkTrials, reqs = { mobid = set{ 17224019 } } }, -- Bloodpool Vorax
[ 217] = { check = checks.checkTrials, reqs = { mobid = set{ 17199564 } } }, -- Golden Bat
[ 218] = { check = checks.checkTrials, reqs = { mobid = set{ 17293389 } } }, -- Slippery Sucker
[ 219] = { check = checks.checkTrials, reqs = { mobid = set{ 17498301 } } }, -- Seww the Squidlimbed
[ 220] = { check = checks.checkTrials, reqs = { mobid = set{ 17137705 } } }, -- Ankabut
[ 221] = { check = checks.checkTrials, reqs = { mobid = set{ 16879847 } } }, -- Okyupete
[ 222] = { check = checks.checkTrials, reqs = { mobid = set{ 17178923 } } }, -- Urd
[ 223] = { check = checks.checkTrials, reqs = { mobid = set{ 17138078, 17146178 } } }, -- Lamprey Lord
[1246] = { check = checks.checkTrials, reqs = { mobid = set{ 17195485 } } }, -- Chesma
[ 282] = { check = checks.checkTrials, reqs = { mobid = set{ 17203585, 17203642 } } }, -- Panzer Percival
[ 283] = { check = checks.checkTrials, reqs = { mobid = set{ 17379450 } } }, -- Ge'Dha Evileye
[ 284] = { check = checks.checkTrials, reqs = { mobid = set{ 17268788 } } }, -- Bashe
[ 285] = { check = checks.checkTrials, reqs = { mobid = set{ 16793742 } } }, -- Intulo
[ 286] = { check = checks.checkTrials, reqs = { mobid = set{ 17166705 } } }, -- Ramponneau
[ 287] = { check = checks.checkTrials, reqs = { mobid = set{ 17272978 } } }, -- Keeper of Halidom
[ 288] = { check = checks.checkTrials, reqs = { mobid = set{ 17138077, 17146177 } } }, -- Shoggoth
[ 289] = { check = checks.checkTrials, reqs = { mobid = set{ 17166769, 17174908 } } }, -- Farruca Fly
[1293] = { check = checks.checkTrials, reqs = { mobid = set{ 17195484 } } }, -- Tammuz
[ 364] = { check = checks.checkTrials, reqs = { mobid = set{ 17371515 } } }, -- Hoo Mjuu the Torrent
[ 365] = { check = checks.checkTrials, reqs = { mobid = set{ 17264818 } } }, -- Daggerclaw Dracos
[ 366] = { check = checks.checkTrials, reqs = { mobid = set{ 17498184 } } }, -- Namtar
[ 367] = { check = checks.checkTrials, reqs = { mobid = set{ 17232079 } } }, -- Gargantua
[ 368] = { check = checks.checkTrials, reqs = { mobid = set{ 16875741 } } }, -- Megalobugard
[ 369] = { check = checks.checkTrials, reqs = { mobid = set{ 17170475 } } }, -- Ratatoskr
[ 370] = { check = checks.checkTrials, reqs = { mobid = set{ 17174909, 17166770 } } }, -- Jyeshtha
[ 371] = { check = checks.checkTrials, reqs = { mobid = set{ 17109385, 17113492 } } }, -- Capricornus
[1354] = { check = checks.checkTrials, reqs = { mobid = set{ 17195485 } } }, -- Chesma
[ 512] = { check = checks.checkTrials, reqs = { mobid = set{ 17555721 } } }, -- Barbastelle
[ 513] = { check = checks.checkTrials, reqs = { mobid = set{ 17571903 } } }, -- Ah Puch
[ 514] = { check = checks.checkTrials, reqs = { mobid = set{ 17567801 } } }, -- Donggu
[ 515] = { check = checks.checkTrials, reqs = { mobid = set{ 16822423, 16822427 } } }, -- Bugbear Strongman
[ 516] = { check = checks.checkTrials, reqs = { mobid = set{ 17121576 } } }, -- La Velue
[ 517] = { check = checks.checkTrials, reqs = { mobid = set{ 17596628 } } }, -- Hovering Hotpot
[ 518] = { check = checks.checkTrials, reqs = { mobid = set{ 17109384, 17113491 } } }, -- Yacumama
[ 519] = { check = checks.checkTrials, reqs = { mobid = set{ 17334552, 17338598 } } }, -- Feuerunke
[1462] = { check = checks.checkTrials, reqs = { mobid = set{ 17195484 } } }, -- Tammuz
[ 430] = { check = checks.checkTrials, reqs = { mobid = set{ 17563785 } } }, -- Slendlix Spindlethumb
[ 431] = { check = checks.checkTrials, reqs = { mobid = set{ 17256836 } } }, -- Herbage Hunter
[ 432] = { check = checks.checkTrials, reqs = { mobid = set{ 17232044 } } }, -- Kirata
[ 433] = { check = checks.checkTrials, reqs = { mobid = set{ 16793742 } } }, -- Intulo
[ 434] = { check = checks.checkTrials, reqs = { mobid = set{ 17166705 } } }, -- Ramponneau
[ 435] = { check = checks.checkTrials, reqs = { mobid = set{ 17272978 } } }, -- Keeper of Halidom
[ 436] = { check = checks.checkTrials, reqs = { mobid = set{ 17138077, 17146177 } } }, -- Shoggoth
[ 437] = { check = checks.checkTrials, reqs = { mobid = set{ 17166769, 17174908 } } }, -- Farruca Fly
[1400] = { check = checks.checkTrials, reqs = { mobid = set{ 17195485 } } }, -- Chesma
[ 578] = { check = checks.checkTrials, reqs = { mobid = set{ 17363208 } } }, -- Zi'Ghi Boneeater
[ 579] = { check = checks.checkTrials, reqs = { mobid = set{ 17195317 } } }, -- Lumbering Lambert
[ 580] = { check = checks.checkTrials, reqs = { mobid = set{ 17268851 } } }, -- Deadly Dodo
[ 581] = { check = checks.checkTrials, reqs = { mobid = set{ 17232079 } } }, -- Gargantua
[ 582] = { check = checks.checkTrials, reqs = { mobid = set{ 16875741 } } }, -- Megalobugard
[ 583] = { check = checks.checkTrials, reqs = { mobid = set{ 17170475 } } }, -- Ratatoskr
[ 584] = { check = checks.checkTrials, reqs = { mobid = set{ 17174909, 17166770 } } }, -- Jyeshtha
[ 585] = { check = checks.checkTrials, reqs = { mobid = set{ 17109385, 17113492 } } }, -- Capricornus
[1508] = { check = checks.checkTrials, reqs = { mobid = set{ 17195484 } } }, -- Tammuz
[ 644] = { check = checks.checkTrials, reqs = { mobid = set{ 17371578 } } }, -- Vuu Puqu the Beguiler
[ 645] = { check = checks.checkTrials, reqs = { mobid = set{ 17261003 } } }, -- Buburimboo
[ 646] = { check = checks.checkTrials, reqs = { mobid = set{ 17379564 } } }, -- Zo'Khu Blackcloud
[ 647] = { check = checks.checkTrials, reqs = { mobid = set{ 17498301 } } }, -- Seww the Squidlimbed
[ 648] = { check = checks.checkTrials, reqs = { mobid = set{ 17137705 } } }, -- Ankabut
[ 649] = { check = checks.checkTrials, reqs = { mobid = set{ 16879847 } } }, -- Okyupete
[ 650] = { check = checks.checkTrials, reqs = { mobid = set{ 17178923 } } }, -- Urd
[ 651] = { check = checks.checkTrials, reqs = { mobid = set{ 17138078, 17146178 } } }, -- Lamprey Lord
[1554] = { check = checks.checkTrials, reqs = { mobid = set{ 17195485 } } }, -- Chesma
[ 710] = { check = checks.checkTrials, reqs = { mobid = set{ 17219795, 17219933 } } }, -- Stray Mary
[ 711] = { check = checks.checkTrials, reqs = { mobid = set{ 17387567 } } }, -- Hawkeyed Dnatbat
[ 712] = { check = checks.checkTrials, reqs = { mobid = set{ 17244396 } } }, -- Dune Widow
[ 713] = { check = checks.checkTrials, reqs = { mobid = set{ 17498301 } } }, -- Seww the Squidlimbed
[ 714] = { check = checks.checkTrials, reqs = { mobid = set{ 17137705 } } }, -- Ankabut
[ 715] = { check = checks.checkTrials, reqs = { mobid = set{ 16879847 } } }, -- Okyupete
[ 716] = { check = checks.checkTrials, reqs = { mobid = set{ 17178923 } } }, -- Urd
[ 717] = { check = checks.checkTrials, reqs = { mobid = set{ 17138078, 17146178 } } }, -- Lamprey Lord
[1600] = { check = checks.checkTrials, reqs = { mobid = set{ 17195485 } } }, -- Chesma
[ 776] = { check = checks.checkTrials, reqs = { mobid = set{ 17559584 } } }, -- Teporingo
[ 777] = { check = checks.checkTrials, reqs = { mobid = set{ 17199438 } } }, -- Valkurm Emperor
[ 778] = { check = checks.checkTrials, reqs = { mobid = set{ 17457236 } } }, -- Hyakume
[ 779] = { check = checks.checkTrials, reqs = { mobid = set{ 17137821 } } }, -- Gloomanita
[ 780] = { check = checks.checkTrials, reqs = { mobid = set{ 17281149 } } }, -- Mischievous Micholas
[ 781] = { check = checks.checkTrials, reqs = { mobid = set{ 17289560 } } }, -- Cactuar Cantautor
[ 782] = { check = checks.checkTrials, reqs = { mobid = set{ 17334553, 17338599 } } }, -- Erebus
[ 783] = { check = checks.checkTrials, reqs = { mobid = set{ 17178924 } } }, -- Skuld
[1646] = { check = checks.checkTrials, reqs = { mobid = set{ 17195485 } } }, -- Chesma
[ 941] = { check = checks.checkTrials, reqs = { mobid = set{ 17363258 } } }, -- Be'Hya Hundredwall
[ 942] = { check = checks.checkTrials, reqs = { mobid = set{ 17092898 } } }, -- Jolly Green
[ 943] = { check = checks.checkTrials, reqs = { mobid = set{ 17588278 } } }, -- Trembler Tabitha
[ 944] = { check = checks.checkTrials, reqs = { mobid = set{ 17498301 } } }, -- Seww the Squidlimbed
[ 945] = { check = checks.checkTrials, reqs = { mobid = set{ 17137705 } } }, -- Ankabut
[ 946] = { check = checks.checkTrials, reqs = { mobid = set{ 16879847 } } }, -- Okyupete
[ 947] = { check = checks.checkTrials, reqs = { mobid = set{ 17178923 } } }, -- Urd
[ 948] = { check = checks.checkTrials, reqs = { mobid = set{ 17138078, 17146178 } } }, -- Lamprey Lord
[1788] = { check = checks.checkTrials, reqs = { mobid = set{ 17195485 } } }, -- Chesma
[ 891] = { check = checks.checkTrials, reqs = { mobid = set{ 17571870 } } }, -- Desmodont
[ 892] = { check = checks.checkTrials, reqs = { mobid = set{ 17395816 } } }, -- Moo Ouzi the Swiftblade
[ 893] = { check = checks.checkTrials, reqs = { mobid = set{ 17223797 } } }, -- Ni'Zho Bladebender
[ 894] = { check = checks.checkTrials, reqs = { mobid = set{ 16822423, 16822427 } } }, -- Bugbear Strongman
[ 895] = { check = checks.checkTrials, reqs = { mobid = set{ 17121576 } } }, -- La Velue
[ 896] = { check = checks.checkTrials, reqs = { mobid = set{ 17596628 } } }, -- Hovering Hotpot
[ 897] = { check = checks.checkTrials, reqs = { mobid = set{ 17109384, 17113491 } } }, -- Yacumama
[ 898] = { check = checks.checkTrials, reqs = { mobid = set{ 17334552, 17338598 } } }, -- Feuerunke
[1758] = { check = checks.checkTrials, reqs = { mobid = set{ 17195484 } } }, -- Tammuz

-- Relic Weapon
-- Spharai
[1003] = { check = checks.checkTrials, reqs = { killWithWs=false, wSkill = set{ tpz.weaponskill.FINAL_HEAVEN }, mobSystem = set{ tpz.eco.VERMIN } } },  -- 75 -> 75 DMG+2
[1004] = { check = checks.checkTrials, reqs = { killWithWs=true, wSkill = set{ tpz.weaponskill.FINAL_HEAVEN }, mobSystem = set{ tpz.eco.PLANTOID } } }, -- 75 DMG+2 -> 75 DMG+6
[1826] = { check = checks.checkTrials, reqs = { killWithWs=true, wSkill = set{ tpz.weaponskill.FINAL_HEAVEN }, mobSystem = set{ tpz.eco.BEAST } } },    -- 75 DMG+6 -> 75 DMG+8
[1827] = { check = checks.checkTrials, reqs = { killWithWs=true, wSkill = set{ tpz.weaponskill.FINAL_HEAVEN }, mobSystem = set{ tpz.eco.AMORPH } } },   -- 75 DMG+8 -> 80
[2253] = { check = checks.checkTrials, reqs = { killWithWs=true, wSkill = set{ tpz.weaponskill.FINAL_HEAVEN }, mobSystem = set{ tpz.eco.ARCANA } } },   -- 80 -> 85
[2664] = { check = checks.checkTrials, reqs = { mobid = set{ 17326088 } } }, -- 85 -> 90 (Mildaunegeux)
[3097] = { check = checks.checkTrials, reqs = { mobid = set{ 17330199 } } }, -- 90 -> 95 (Animated Knuckles)
[3560] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3502 } } }, -- 95 -> 99 (Umbral Marrow x5)
[3610] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3502 } } }, -- 99 -> 99 (Umbral Marrow x250)

-- Mandau
[991]  = { check = checks.checkTrials, reqs = { killWithWs=false, wSkill = set{ tpz.weaponskill.MERCY_STROKE }, mobSystem = set{ tpz.eco.BEAST } } },    -- 75 -> 75 DMG+1
[992]  = { check = checks.checkTrials, reqs = { killWithWs=true, wSkill = set{ tpz.weaponskill.MERCY_STROKE }, mobSystem = set{ tpz.eco.VERMIN } } },    -- 75 DMG+1 -> 75 DMG+2
[1818] = { check = checks.checkTrials, reqs = { killWithWs=true, wSkill = set{ tpz.weaponskill.MERCY_STROKE }, mobSystem = set{ tpz.eco.PLANTOID } } },  -- 75 DMG+2 -> 75 DMG+3
[1819] = { check = checks.checkTrials, reqs = { killWithWs=true, wSkill = set{ tpz.weaponskill.MERCY_STROKE }, mobSystem = set{ tpz.eco.BIRD } } },      -- 75 DMG+3 -> 80
[2249] = { check = checks.checkTrials, reqs = { killWithWs=true, wSkill = set{ tpz.weaponskill.MERCY_STROKE }, mobSystem = set{ tpz.eco.DRAGON } } },    -- 80 -> 85
[2660] = { check = checks.checkTrials, reqs = { mobid = set{ 17326087 } } }, -- 85 -> 90 (Quiebitiel)
[3093] = { check = checks.checkTrials, reqs = { mobid = set{ 17330200 } } }, -- 90 -> 95 (Animated Dagger)
[3556] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3502 } } }, -- 95 -> 99 (Umbral Marrow x5)
[3606] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3502 } } }, -- 99 -> 99 (Umbral Marrow x250)

-- Excalibur
[1012] = { check = checks.checkTrials, reqs = { killWithWs=false, wSkill = set{ tpz.weaponskill.KNIGHTS_OF_ROUND }, mobSystem = set{ tpz.eco.AQUAN } } },    -- 75 -> 75 DMG+1
[1013] = { check = checks.checkTrials, reqs = { killWithWs=true, wSkill = set{ tpz.weaponskill.KNIGHTS_OF_ROUND }, mobSystem = set{ tpz.eco.UNDEAD } } },    -- 75 DMG+1 -> 75 DMG+2
[1832] = { check = checks.checkTrials, reqs = { killWithWs=true, wSkill = set{ tpz.weaponskill.KNIGHTS_OF_ROUND }, mobSystem = set{ tpz.eco.LIZARD } } },    -- 75 DMG+2 -> 75 DMG+3
[1833] = { check = checks.checkTrials, reqs = { killWithWs=true, wSkill = set{ tpz.weaponskill.KNIGHTS_OF_ROUND }, mobSystem = set{ tpz.eco.DRAGON } } },    -- 75 DMG+3 -> 80
[2256] = { check = checks.checkTrials, reqs = { killWithWs=true, wSkill = set{ tpz.weaponskill.KNIGHTS_OF_ROUND }, mobSystem = set{ tpz.eco.BIRD } } },      -- 80 -> 85
[2667] = { check = checks.checkTrials, reqs = { mobid = set{ 17326086 } } }, -- 85 -> 90 (Goublefaupe)
[3100] = { check = checks.checkTrials, reqs = { mobid = set{ 17330201 } } }, -- 90 -> 95 (Animated Longsword)
[3563] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3502 } } }, -- 95 -> 99 (Umbral Marrow x5)
[3613] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3502 } } }, -- 99 -> 99 (Umbral Marrow x250)

-- Ragnarok
[1024] = { check = checks.checkTrials, reqs = { killWithWs=false, wSkill = set{ tpz.weaponskill.SCOURGE }, mobSystem = set{ tpz.eco.BIRD } } },     -- 75 -> 75 DMG+3
[1025] = { check = checks.checkTrials, reqs = { killWithWs=true, wSkill = set{ tpz.weaponskill.SCOURGE }, mobSystem = set{ tpz.eco.BEAST } } },     -- 75 DMG+3 -> 75 DMG+9
[1840] = { check = checks.checkTrials, reqs = { killWithWs=true, wSkill = set{ tpz.weaponskill.SCOURGE }, mobSystem = set{ tpz.eco.AQUAN } } },     -- 75 DMG+9 -> 75 DMG+10
[1841] = { check = checks.checkTrials, reqs = { killWithWs=true, wSkill = set{ tpz.weaponskill.SCOURGE }, mobSystem = set{ tpz.eco.UNDEAD } } },    -- 75 DMG+10 -> 80
[2260] = { check = checks.checkTrials, reqs = { killWithWs=true, wSkill = set{ tpz.weaponskill.SCOURGE }, mobSystem = set{ tpz.eco.ARCANA } } },    -- 80 -> 85
[2671] = { check = checks.checkTrials, reqs = { mobid = set{ 17326086 } } }, -- 85 -> 90 (Goublefaupe)
[3104] = { check = checks.checkTrials, reqs = { mobid = set{ 17330202 } } }, -- 90 -> 95 (Animated Claymore)
[3567] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3502 } } }, -- 95 -> 99 (Umbral Marrow x5)
[3617] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3502 } } }, -- 99 -> 99 (Umbral Marrow x250)

-- Guttler
[1027] = { check = checks.checkTrials, reqs = { killWithWs=false, wSkill = set{ tpz.weaponskill.ONSLAUGHT }, mobSystem = set{ tpz.eco.UNDEAD } } },   -- 75 -> 75 DMG+2
[1028] = { check = checks.checkTrials, reqs = { killWithWs=true, wSkill = set{ tpz.weaponskill.ONSLAUGHT }, mobSystem = set{ tpz.eco.ARCANA } } },    -- 75 DMG+2 -> 75 DMG+6
[1842] = { check = checks.checkTrials, reqs = { killWithWs=true, wSkill = set{ tpz.weaponskill.ONSLAUGHT }, mobSystem = set{ tpz.eco.BEAST } } },     -- 75 DMG+6 -> 75 DMG+7
[1843] = { check = checks.checkTrials, reqs = { killWithWs=true, wSkill = set{ tpz.weaponskill.ONSLAUGHT }, mobSystem = set{ tpz.eco.AMORPH } } },    -- 75 DMG+7 -> 80
[2261] = { check = checks.checkTrials, reqs = { killWithWs=true, wSkill = set{ tpz.weaponskill.ONSLAUGHT }, mobSystem = set{ tpz.eco.BIRD } } },      -- 80 -> 85
[2672] = { check = checks.checkTrials, reqs = { mobid = set{ 17326090 } } }, -- 85 -> 90 (Dagourmarche)
[3105] = { check = checks.checkTrials, reqs = { mobid = set{ 17330203 } } }, -- 90 -> 95 (Animated Tabar)
[3568] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3502 } } }, -- 95 -> 99 (Umbral Marrow x5)
[3618] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3502 } } }, -- 99 -> 99 (Umbral Marrow x250)

-- Bravura
[1033] = { check = checks.checkTrials, reqs = { killWithWs=false, wSkill = set{ tpz.weaponskill.METATRON_TORMENT }, mobSystem = set{ tpz.eco.LIZARD } } },   -- 75 -> 75 DMG+3
[1034] = { check = checks.checkTrials, reqs = { killWithWs=true, wSkill = set{ tpz.weaponskill.METATRON_TORMENT }, mobSystem = set{ tpz.eco.PLANTOID } } },  -- 75 DMG+3 -> 75 DMG+7
[1846] = { check = checks.checkTrials, reqs = { killWithWs=true, wSkill = set{ tpz.weaponskill.METATRON_TORMENT }, mobSystem = set{ tpz.eco.UNDEAD } } },    -- 75 DMG+7 -> 75 DMG+9
[1847] = { check = checks.checkTrials, reqs = { killWithWs=true, wSkill = set{ tpz.weaponskill.METATRON_TORMENT }, mobSystem = set{ tpz.eco.PLANTOID } } },  -- 75 DMG+9 -> 80
[2263] = { check = checks.checkTrials, reqs = { killWithWs=true, wSkill = set{ tpz.weaponskill.METATRON_TORMENT }, mobSystem = set{ tpz.eco.DRAGON } } },    -- 80 -> 85
[2674] = { check = checks.checkTrials, reqs = { mobid = set{ 17326086 } } }, -- 85 -> 90 (Goublefaupe)
[3107] = { check = checks.checkTrials, reqs = { mobid = set{ 17330204 } } }, -- 90 -> 95 (Animated Great Axe)
[3570] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3502 } } }, -- 95 -> 99 (Umbral Marrow x5)
[3620] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3502 } } }, -- 99 -> 99 (Umbral Marrow x250)

-- Gungnir
[1039] = { check = checks.checkTrials, reqs = { killWithWs=false, wSkill = set{ tpz.weaponskill.GEIRSKOGUL }, mobSystem = set{ tpz.eco.AMORPH } } },  -- 75 -> 75 DMG+3
[1040] = { check = checks.checkTrials, reqs = { killWithWs=true, wSkill = set{ tpz.weaponskill.GEIRSKOGUL }, mobSystem = set{ tpz.eco.LIZARD } } },   -- 75 DMG+3 -> 75 DMG+7
[1850] = { check = checks.checkTrials, reqs = { killWithWs=true, wSkill = set{ tpz.weaponskill.GEIRSKOGUL }, mobSystem = set{ tpz.eco.ARCANA } } },   -- 75 DMG+7 -> 75 DMG+9
[1851] = { check = checks.checkTrials, reqs = { killWithWs=true, wSkill = set{ tpz.weaponskill.GEIRSKOGUL }, mobSystem = set{ tpz.eco.VERMIN } } },   -- 75 DMG+9 -> 80
[2267] = { check = checks.checkTrials, reqs = { killWithWs=true, wSkill = set{ tpz.weaponskill.GEIRSKOGUL }, mobSystem = set{ tpz.eco.AQUAN } } },    -- 80 -> 85
[2678] = { check = checks.checkTrials, reqs = { mobid = set{ 17326090 } } }, -- 85 -> 90 (Dagourmarche)
[3111] = { check = checks.checkTrials, reqs = { mobid = set{ 17330205 } } }, -- 90 -> 95 (Animated Spear)
[3574] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3502 } } }, -- 95 -> 99 (Umbral Marrow x5)
[3624] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3502 } } }, -- 99 -> 99 (Umbral Marrow x250)

-- Apocalypse
[1045] = { check = checks.checkTrials, reqs = { killWithWs=false, wSkill = set{ tpz.weaponskill.CATASTROPHE }, mobSystem = set{ tpz.eco.UNDEAD } } },  -- 75 -> 75 DMG+3
[1046] = { check = checks.checkTrials, reqs = { killWithWs=true, wSkill = set{ tpz.weaponskill.CATASTROPHE }, mobSystem = set{ tpz.eco.AQUAN } } },    -- 75 DMG+3 -> 75 DMG+7
[1854] = { check = checks.checkTrials, reqs = { killWithWs=true, wSkill = set{ tpz.weaponskill.CATASTROPHE }, mobSystem = set{ tpz.eco.LIZARD } } },   -- 75 DMG+7 -> 75 DMG+9
[1855] = { check = checks.checkTrials, reqs = { killWithWs=true, wSkill = set{ tpz.weaponskill.CATASTROPHE }, mobSystem = set{ tpz.eco.BIRD } } },     -- 75 DMG+9 -> 80
[2265] = { check = checks.checkTrials, reqs = { killWithWs=true, wSkill = set{ tpz.weaponskill.CATASTROPHE }, mobSystem = set{ tpz.eco.BEAST } } },    -- 80 -> 85
[2676] = { check = checks.checkTrials, reqs = { mobid = set{ 17326089 } } }, -- 85 -> 90 (Velosareon)
[3109] = { check = checks.checkTrials, reqs = { mobid = set{ 17330206 } } }, -- 90 -> 95 (Animated Scythe)
[3572] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3502 } } }, -- 95 -> 99 (Umbral Marrow x5)
[3622] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3502 } } }, -- 99 -> 99 (Umbral Marrow x250)

-- Kikoku
[1051] = { check = checks.checkTrials, reqs = { killWithWs=false, wSkill = set{ tpz.weaponskill.BLADE_METSU }, mobSystem = set{ tpz.eco.BIRD } } },    -- 75 -> 75 DMG+1
[1052] = { check = checks.checkTrials, reqs = { killWithWs=true, wSkill = set{ tpz.weaponskill.BLADE_METSU }, mobSystem = set{ tpz.eco.ARCANA } } },   -- 75 DMG+1 -> 75 DMG+3
[1858] = { check = checks.checkTrials, reqs = { killWithWs=true, wSkill = set{ tpz.weaponskill.BLADE_METSU }, mobSystem = set{ tpz.eco.AMORPH } } },   -- 75 DMG+3 -> 75 DMG+4
[1859] = { check = checks.checkTrials, reqs = { killWithWs=true, wSkill = set{ tpz.weaponskill.BLADE_METSU }, mobSystem = set{ tpz.eco.AQUAN } } },    -- 75 DMG+4 -> 80
[2269] = { check = checks.checkTrials, reqs = { killWithWs=true, wSkill = set{ tpz.weaponskill.BLADE_METSU }, mobSystem = set{ tpz.eco.UNDEAD } } },   -- 80 -> 85
[2680] = { check = checks.checkTrials, reqs = { mobid = set{ 17326088 } } }, -- 85 -> 90 (Mildaunegeux)
[3113] = { check = checks.checkTrials, reqs = { mobid = set{ 17330207 } } }, -- 90 -> 95 (Animated Kunai)
[3576] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3502 } } }, -- 95 -> 99 (Umbral Marrow x5)
[3626] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3502 } } }, -- 99 -> 99 (Umbral Marrow x250)

-- Amanomurakumo
[1057] = { check = checks.checkTrials, reqs = { killWithWs=false, wSkill = set{ tpz.weaponskill.TACHI_KAITEN }, mobSystem = set{ tpz.eco.BEAST } } },    -- 75 -> 75 DMG+2
[1058] = { check = checks.checkTrials, reqs = { killWithWs=true, wSkill = set{ tpz.weaponskill.TACHI_KAITEN }, mobSystem = set{ tpz.eco.VERMIN } } },    -- 75 DMG+2 -> 75 DMG+5
[1862] = { check = checks.checkTrials, reqs = { killWithWs=true, wSkill = set{ tpz.weaponskill.TACHI_KAITEN }, mobSystem = set{ tpz.eco.ARCANA } } },    -- 75 DMG+5 -> 75 DMG+6
[1863] = { check = checks.checkTrials, reqs = { killWithWs=true, wSkill = set{ tpz.weaponskill.TACHI_KAITEN }, mobSystem = set{ tpz.eco.BIRD } } },      -- 75 DMG+6 -> 80
[2271] = { check = checks.checkTrials, reqs = { killWithWs=true, wSkill = set{ tpz.weaponskill.TACHI_KAITEN }, mobSystem = set{ tpz.eco.AQUAN } } },     -- 80 -> 85
[2682] = { check = checks.checkTrials, reqs = { mobid = set{ 17326089 } } }, -- 85 -> 90 (Velosareon)
[3115] = { check = checks.checkTrials, reqs = { mobid = set{ 17330208 } } }, -- 90 -> 95 (Animated Tachi)
[3578] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3502 } } }, -- 95 -> 99 (Umbral Marrow x5)
[3628] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3502 } } }, -- 99 -> 99 (Umbral Marrow x250)

-- Mjollnir
[1063] = { check = checks.checkTrials, reqs = { killWithWs=false, wSkill = set{ tpz.weaponskill.RANDGRITH }, mobSystem = set{ tpz.eco.LIZARD } } },   -- 75 -> 75 DMG+2
[1064] = { check = checks.checkTrials, reqs = { killWithWs=true, wSkill = set{ tpz.weaponskill.RANDGRITH }, mobSystem = set{ tpz.eco.BEAST } } },     -- 75 DMG+2 -> 75 DMG+8
[1866] = { check = checks.checkTrials, reqs = { killWithWs=true, wSkill = set{ tpz.weaponskill.RANDGRITH }, mobSystem = set{ tpz.eco.AMORPH } } },    -- 75 DMG+8 -> 75 DMG+9
[1867] = { check = checks.checkTrials, reqs = { killWithWs=true, wSkill = set{ tpz.weaponskill.RANDGRITH }, mobSystem = set{ tpz.eco.VERMIN } } },    -- 75 DMG+9 -> 80
[2273] = { check = checks.checkTrials, reqs = { killWithWs=true, wSkill = set{ tpz.weaponskill.RANDGRITH }, mobSystem = set{ tpz.eco.BIRD } } },      -- 80 -> 85
[2684] = { check = checks.checkTrials, reqs = { mobid = set{ 17326087 } } }, -- 85 -> 90 (Quiebitiel)
[3117] = { check = checks.checkTrials, reqs = { mobid = set{ 17330209 } } }, -- 90 -> 95 (Animated Tachi)
[3581] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3502 } } }, -- 95 -> 99 (Umbral Marrow x5)
[3630] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3502 } } }, -- 99 -> 99 (Umbral Marrow x250)

-- Claustrum
[1069] = { check = checks.checkTrials, reqs = { killWithWs=false, wSkill = set{ tpz.weaponskill.GATE_OF_TARTARUS }, mobSystem = set{ tpz.eco.AQUAN } } },   -- 75 -> 75 DMG+4
[1070] = { check = checks.checkTrials, reqs = { killWithWs=true, wSkill = set{ tpz.weaponskill.GATE_OF_TARTARUS }, mobSystem = set{ tpz.eco.LIZARD } } },   -- 75 DMG+4 -> 75 DMG+10
[1870] = { check = checks.checkTrials, reqs = { killWithWs=true, wSkill = set{ tpz.weaponskill.GATE_OF_TARTARUS }, mobSystem = set{ tpz.eco.UNDEAD } } },   -- 75 DMG+10 -> 75 DMG+12
[1871] = { check = checks.checkTrials, reqs = { killWithWs=true, wSkill = set{ tpz.weaponskill.GATE_OF_TARTARUS }, mobSystem = set{ tpz.eco.BEAST } } },    -- 75 DMG+12 -> 80
[2275] = { check = checks.checkTrials, reqs = { killWithWs=true, wSkill = set{ tpz.weaponskill.GATE_OF_TARTARUS }, mobSystem = set{ tpz.eco.PLANTOID } } }, -- 80 -> 85
[2686] = { check = checks.checkTrials, reqs = { mobid = set{ 17326090 } } }, -- 85 -> 90 (Dagourmarche)
[3119] = { check = checks.checkTrials, reqs = { mobid = set{ 17330210 } } }, -- 90 -> 95 (Animated Staff)
[3582] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3502 } } }, -- 95 -> 99 (Umbral Marrow x5)
[3632] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3502 } } }, -- 99 -> 99 (Umbral Marrow x250)

-- Annihilator
[1081] = { check = checks.checkTrials, reqs = { killWithWs=false, wSkill = set{ tpz.weaponskill.CORONACH }, mobSystem = set{ tpz.eco.BEAST } } },    -- 75 -> 75 DMG+2
[1082] = { check = checks.checkTrials, reqs = { killWithWs=true, wSkill = set{ tpz.weaponskill.CORONACH }, mobSystem = set{ tpz.eco.AQUAN } } },     -- 75 DMG+2 -> 75 DMG+6
[1878] = { check = checks.checkTrials, reqs = { killWithWs=true, wSkill = set{ tpz.weaponskill.CORONACH }, mobSystem = set{ tpz.eco.ARCANA } } },    -- 75 DMG+6 -> 75 DMG+8
[1879] = { check = checks.checkTrials, reqs = { killWithWs=true, wSkill = set{ tpz.weaponskill.CORONACH }, mobSystem = set{ tpz.eco.PLANTOID } } },  -- 75 DMG+8 -> 80
[2280] = { check = checks.checkTrials, reqs = { killWithWs=true, wSkill = set{ tpz.weaponskill.CORONACH }, mobSystem = set{ tpz.eco.UNDEAD } } },    -- 80 -> 85
[2691] = { check = checks.checkTrials, reqs = { mobid = set{ 17326088 } } }, -- 85 -> 90 (Mildaunegeux)
[3124] = { check = checks.checkTrials, reqs = { mobid = set{ 17330212 } } }, -- 90 -> 95 (Animated Gun)
[3587] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3502 } } }, -- 95 -> 99 (Umbral Marrow x5)
[3637] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3502 } } }, -- 99 -> 99 (Umbral Marrow x250)

-- Yoichinoyumi
[1090] = { check = checks.checkTrials, reqs = { killWithWs=false, wSkill = set{ tpz.weaponskill.NAMAS_ARROW }, mobSystem = set{ tpz.eco.AMORPH } } },   -- 75 -> 75 DMG+2
[1091] = { check = checks.checkTrials, reqs = { killWithWs=true, wSkill = set{ tpz.weaponskill.NAMAS_ARROW }, mobSystem = set{ tpz.eco.BEAST } } },     -- 75 DMG+2 -> 75 DMG+5
[1884] = { check = checks.checkTrials, reqs = { killWithWs=true, wSkill = set{ tpz.weaponskill.NAMAS_ARROW }, mobSystem = set{ tpz.eco.LIZARD } } },    -- 75 DMG+5 -> 75 DMG+8
[1885] = { check = checks.checkTrials, reqs = { killWithWs=true, wSkill = set{ tpz.weaponskill.NAMAS_ARROW }, mobSystem = set{ tpz.eco.AQUAN } } },     -- 75 DMG+8 -> 80
[2279] = { check = checks.checkTrials, reqs = { killWithWs=true, wSkill = set{ tpz.weaponskill.NAMAS_ARROW }, mobSystem = set{ tpz.eco.VERMIN } } },    -- 80 -> 85
[2690] = { check = checks.checkTrials, reqs = { mobid = set{ 17326089 } } }, -- 85 -> 90 (Velosareon)
[3123] = { check = checks.checkTrials, reqs = { mobid = set{ 17330211 } } }, -- 90 -> 95 (Animated Longbow)
[3586] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3502 } } }, -- 95 -> 99 (Umbral Marrow x5)
[3636] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3502 } } }, -- 99 -> 99 (Umbral Marrow x250)

-- Gjallarhorn
[2713] = { check = checks.checkTrials, reqs = { mobid = set{ 17547265 } } }, -- 75 -> 80 (Goblin Golem)
[2714] = { check = checks.checkTrials, reqs = { mobid = set{ 17543169 } } }, -- 80 -> 85 (Tzee Xicu Idol)
[2715] = { check = checks.checkTrials, reqs = { mobid = set{ 17326087 } } }, -- 85 -> 90 (Quiebitiel)
[3128] = { check = checks.checkTrials, reqs = { mobid = set{ 17330213 } } }, -- 90 -> 95 (Animated Horn)
[3591] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3502 } } }, -- 95 -> 99 (Umbral Marrow x5)
[3641] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3502 } } }, -- 99 -> 99 (Umbral Marrow x250)

-- Aegis
[4401] = { check = checks.checkTrials, reqs = { mobid = set{ 17539073 } } }, -- 75 -> 80 (Gu'Dha Effigy)
[4402] = { check = checks.checkTrials, reqs = { mobid = set{ 17534977 } } }, -- 80 -> 85 (Overlord's Tombstone)
[4403] = { check = checks.checkTrials, reqs = { mobid = set{ 17326086 } } }, -- 85 -> 90 (Goublefaupe)
[4448] = { check = checks.checkTrials, reqs = { mobid = set{ 17330214 } } }, -- 90 -> 95 (Animated Shield)
[4453] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3502 } } }, -- 95 -> 99 (Umbral Marrow x5)
[5056] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3502 } } }, -- 99 -> 99 (Umbral Marrow x250)

 -- Unkai Kote
[4327] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3161 } } }, -- 0 -> +1 (Unkai Seal: Hn.)
}
