-----------------------------------
-- Magian Trial Objectives
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/weaponskillids")
-----------------------------------

-- This is a table of anon function for Magian Trial objectives/conditions.
-- Keyed by trial ID, if they return true, the trials progress is incremented and saved.

xi = xi or {}
xi.magian = xi.magian or {}
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
    end

    return ismobkill
end

checks.checkTradeTrials = function(self, player, params)
    return self.reqs.itemId[params.itemId] ~= nil and params.quantity or 0
end

xi.magian.trials =
{
[   2] = { check = checks.checkTrials, reqs = { mobid = set{ 17563801 } } }, -- Nocuous Weapon
[   3] = { check = checks.checkTrials, reqs = { mobid = set{ 17227972, 17227992 } } }, -- Black Triple Stars
[   4] = { check = checks.checkTrials, reqs = { mobid = set{ 16793646 } } }, -- Serra
[   5] = { check = checks.checkTrials, reqs = { mobid = set{ 16822423, 16822427 } } }, -- Bugbear Strongman
[   6] = { check = checks.checkTrials, reqs = { mobid = set{ 17121576 } } }, -- La Velue
[   7] = { check = checks.checkTrials, reqs = { mobid = set{ 17596628 } } }, -- Hovering Hotpot
[   8] = { check = checks.checkTrials, reqs = { mobid = set{ 17109384, 17113491 } } }, -- Yacumama
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
[1003] = { check = checks.checkTrials, reqs = { killWithWs = false, wSkill = set{ xi.weaponskill.FINAL_HEAVEN }, mobSystem = set{ xi.eco.VERMIN } } },  -- 75 -> 75 DMG+2
[1004] = { check = checks.checkTrials, reqs = { killWithWs = true, wSkill = set{ xi.weaponskill.FINAL_HEAVEN }, mobSystem = set{ xi.eco.PLANTOID } } }, -- 75 DMG+2 -> 75 DMG+6
[1826] = { check = checks.checkTrials, reqs = { killWithWs = true, wSkill = set{ xi.weaponskill.FINAL_HEAVEN }, mobSystem = set{ xi.eco.BEAST } } },    -- 75 DMG+6 -> 75 DMG+8
[1827] = { check = checks.checkTrials, reqs = { killWithWs = true, wSkill = set{ xi.weaponskill.FINAL_HEAVEN }, mobSystem = set{ xi.eco.AMORPH } } },   -- 75 DMG+8 -> 80
[2253] = { check = checks.checkTrials, reqs = { killWithWs = true, wSkill = set{ xi.weaponskill.FINAL_HEAVEN }, mobSystem = set{ xi.eco.ARCANA } } },   -- 80 -> 85
[2664] = { check = checks.checkTrials, reqs = { mobid = set{ 17326088 } } }, -- 85 -> 90 (Mildaunegeux)
[3097] = { check = checks.checkTrials, reqs = { mobid = set{ 17330199 } } }, -- 90 -> 95 (Animated Knuckles)
[3560] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3502 } } }, -- 95 -> 99 (Umbral Marrow x5)
[3610] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3502 } } }, -- 99 -> 99 (Umbral Marrow x250)

-- Mandau
[991]  = { check = checks.checkTrials, reqs = { killWithWs = false, wSkill = set{ xi.weaponskill.MERCY_STROKE }, mobSystem = set{ xi.eco.BEAST } } },    -- 75 -> 75 DMG+1
[992]  = { check = checks.checkTrials, reqs = { killWithWs = true, wSkill = set{ xi.weaponskill.MERCY_STROKE }, mobSystem = set{ xi.eco.VERMIN } } },    -- 75 DMG+1 -> 75 DMG+2
[1818] = { check = checks.checkTrials, reqs = { killWithWs = true, wSkill = set{ xi.weaponskill.MERCY_STROKE }, mobSystem = set{ xi.eco.PLANTOID } } },  -- 75 DMG+2 -> 75 DMG+3
[1819] = { check = checks.checkTrials, reqs = { killWithWs = true, wSkill = set{ xi.weaponskill.MERCY_STROKE }, mobSystem = set{ xi.eco.BIRD } } },      -- 75 DMG+3 -> 80
[2249] = { check = checks.checkTrials, reqs = { killWithWs = true, wSkill = set{ xi.weaponskill.MERCY_STROKE }, mobSystem = set{ xi.eco.DRAGON } } },    -- 80 -> 85
[2660] = { check = checks.checkTrials, reqs = { mobid = set{ 17326087 } } }, -- 85 -> 90 (Quiebitiel)
[3093] = { check = checks.checkTrials, reqs = { mobid = set{ 17330200 } } }, -- 90 -> 95 (Animated Dagger)
[3556] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3502 } } }, -- 95 -> 99 (Umbral Marrow x5)
[3606] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3502 } } }, -- 99 -> 99 (Umbral Marrow x250)

-- Excalibur
[1012] = { check = checks.checkTrials, reqs = { killWithWs = false, wSkill = set{ xi.weaponskill.KNIGHTS_OF_ROUND }, mobSystem = set{ xi.eco.AQUAN } } },    -- 75 -> 75 DMG+1
[1013] = { check = checks.checkTrials, reqs = { killWithWs = true, wSkill = set{ xi.weaponskill.KNIGHTS_OF_ROUND }, mobSystem = set{ xi.eco.UNDEAD } } },    -- 75 DMG+1 -> 75 DMG+2
[1832] = { check = checks.checkTrials, reqs = { killWithWs = true, wSkill = set{ xi.weaponskill.KNIGHTS_OF_ROUND }, mobSystem = set{ xi.eco.LIZARD } } },    -- 75 DMG+2 -> 75 DMG+3
[1833] = { check = checks.checkTrials, reqs = { killWithWs = true, wSkill = set{ xi.weaponskill.KNIGHTS_OF_ROUND }, mobSystem = set{ xi.eco.DRAGON } } },    -- 75 DMG+3 -> 80
[2256] = { check = checks.checkTrials, reqs = { killWithWs = true, wSkill = set{ xi.weaponskill.KNIGHTS_OF_ROUND }, mobSystem = set{ xi.eco.BIRD } } },      -- 80 -> 85
[2667] = { check = checks.checkTrials, reqs = { mobid = set{ 17326086 } } }, -- 85 -> 90 (Goublefaupe)
[3100] = { check = checks.checkTrials, reqs = { mobid = set{ 17330201 } } }, -- 90 -> 95 (Animated Longsword)
[3563] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3502 } } }, -- 95 -> 99 (Umbral Marrow x5)
[3613] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3502 } } }, -- 99 -> 99 (Umbral Marrow x250)

-- Ragnarok
[1024] = { check = checks.checkTrials, reqs = { killWithWs = false, wSkill = set{ xi.weaponskill.SCOURGE }, mobSystem = set{ xi.eco.BIRD } } },     -- 75 -> 75 DMG+3
[1025] = { check = checks.checkTrials, reqs = { killWithWs = true, wSkill = set{ xi.weaponskill.SCOURGE }, mobSystem = set{ xi.eco.BEAST } } },     -- 75 DMG+3 -> 75 DMG+9
[1840] = { check = checks.checkTrials, reqs = { killWithWs = true, wSkill = set{ xi.weaponskill.SCOURGE }, mobSystem = set{ xi.eco.AQUAN } } },     -- 75 DMG+9 -> 75 DMG+10
[1841] = { check = checks.checkTrials, reqs = { killWithWs = true, wSkill = set{ xi.weaponskill.SCOURGE }, mobSystem = set{ xi.eco.UNDEAD } } },    -- 75 DMG+10 -> 80
[2260] = { check = checks.checkTrials, reqs = { killWithWs = true, wSkill = set{ xi.weaponskill.SCOURGE }, mobSystem = set{ xi.eco.ARCANA } } },    -- 80 -> 85
[2671] = { check = checks.checkTrials, reqs = { mobid = set{ 17326086 } } }, -- 85 -> 90 (Goublefaupe)
[3104] = { check = checks.checkTrials, reqs = { mobid = set{ 17330202 } } }, -- 90 -> 95 (Animated Claymore)
[3567] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3502 } } }, -- 95 -> 99 (Umbral Marrow x5)
[3617] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3502 } } }, -- 99 -> 99 (Umbral Marrow x250)

-- Guttler
[1027] = { check = checks.checkTrials, reqs = { killWithWs = false, wSkill = set{ xi.weaponskill.ONSLAUGHT }, mobSystem = set{ xi.eco.UNDEAD } } },   -- 75 -> 75 DMG+2
[1028] = { check = checks.checkTrials, reqs = { killWithWs = true, wSkill = set{ xi.weaponskill.ONSLAUGHT }, mobSystem = set{ xi.eco.ARCANA } } },    -- 75 DMG+2 -> 75 DMG+6
[1842] = { check = checks.checkTrials, reqs = { killWithWs = true, wSkill = set{ xi.weaponskill.ONSLAUGHT }, mobSystem = set{ xi.eco.BEAST } } },     -- 75 DMG+6 -> 75 DMG+7
[1843] = { check = checks.checkTrials, reqs = { killWithWs = true, wSkill = set{ xi.weaponskill.ONSLAUGHT }, mobSystem = set{ xi.eco.AMORPH } } },    -- 75 DMG+7 -> 80
[2261] = { check = checks.checkTrials, reqs = { killWithWs = true, wSkill = set{ xi.weaponskill.ONSLAUGHT }, mobSystem = set{ xi.eco.BIRD } } },      -- 80 -> 85
[2672] = { check = checks.checkTrials, reqs = { mobid = set{ 17326090 } } }, -- 85 -> 90 (Dagourmarche)
[3105] = { check = checks.checkTrials, reqs = { mobid = set{ 17330203 } } }, -- 90 -> 95 (Animated Tabar)
[3568] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3502 } } }, -- 95 -> 99 (Umbral Marrow x5)
[3618] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3502 } } }, -- 99 -> 99 (Umbral Marrow x250)

-- Bravura
[1033] = { check = checks.checkTrials, reqs = { killWithWs = false, wSkill = set{ xi.weaponskill.METATRON_TORMENT }, mobSystem = set{ xi.eco.LIZARD } } },   -- 75 -> 75 DMG+3
[1034] = { check = checks.checkTrials, reqs = { killWithWs = true, wSkill = set{ xi.weaponskill.METATRON_TORMENT }, mobSystem = set{ xi.eco.PLANTOID } } },  -- 75 DMG+3 -> 75 DMG+7
[1846] = { check = checks.checkTrials, reqs = { killWithWs = true, wSkill = set{ xi.weaponskill.METATRON_TORMENT }, mobSystem = set{ xi.eco.UNDEAD } } },    -- 75 DMG+7 -> 75 DMG+9
[1847] = { check = checks.checkTrials, reqs = { killWithWs = true, wSkill = set{ xi.weaponskill.METATRON_TORMENT }, mobSystem = set{ xi.eco.PLANTOID } } },  -- 75 DMG+9 -> 80
[2263] = { check = checks.checkTrials, reqs = { killWithWs = true, wSkill = set{ xi.weaponskill.METATRON_TORMENT }, mobSystem = set{ xi.eco.DRAGON } } },    -- 80 -> 85
[2674] = { check = checks.checkTrials, reqs = { mobid = set{ 17326086 } } }, -- 85 -> 90 (Goublefaupe)
[3107] = { check = checks.checkTrials, reqs = { mobid = set{ 17330204 } } }, -- 90 -> 95 (Animated Great Axe)
[3570] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3502 } } }, -- 95 -> 99 (Umbral Marrow x5)
[3620] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3502 } } }, -- 99 -> 99 (Umbral Marrow x250)

-- Gungnir
[1039] = { check = checks.checkTrials, reqs = { killWithWs = false, wSkill = set{ xi.weaponskill.GEIRSKOGUL }, mobSystem = set{ xi.eco.AMORPH } } },  -- 75 -> 75 DMG+3
[1040] = { check = checks.checkTrials, reqs = { killWithWs = true, wSkill = set{ xi.weaponskill.GEIRSKOGUL }, mobSystem = set{ xi.eco.LIZARD } } },   -- 75 DMG+3 -> 75 DMG+7
[1850] = { check = checks.checkTrials, reqs = { killWithWs = true, wSkill = set{ xi.weaponskill.GEIRSKOGUL }, mobSystem = set{ xi.eco.ARCANA } } },   -- 75 DMG+7 -> 75 DMG+9
[1851] = { check = checks.checkTrials, reqs = { killWithWs = true, wSkill = set{ xi.weaponskill.GEIRSKOGUL }, mobSystem = set{ xi.eco.VERMIN } } },   -- 75 DMG+9 -> 80
[2267] = { check = checks.checkTrials, reqs = { killWithWs = true, wSkill = set{ xi.weaponskill.GEIRSKOGUL }, mobSystem = set{ xi.eco.AQUAN } } },    -- 80 -> 85
[2678] = { check = checks.checkTrials, reqs = { mobid = set{ 17326090 } } }, -- 85 -> 90 (Dagourmarche)
[3111] = { check = checks.checkTrials, reqs = { mobid = set{ 17330205 } } }, -- 90 -> 95 (Animated Spear)
[3574] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3502 } } }, -- 95 -> 99 (Umbral Marrow x5)
[3624] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3502 } } }, -- 99 -> 99 (Umbral Marrow x250)

-- Apocalypse
[1045] = { check = checks.checkTrials, reqs = { killWithWs = false, wSkill = set{ xi.weaponskill.CATASTROPHE }, mobSystem = set{ xi.eco.UNDEAD } } },  -- 75 -> 75 DMG+3
[1046] = { check = checks.checkTrials, reqs = { killWithWs = true, wSkill = set{ xi.weaponskill.CATASTROPHE }, mobSystem = set{ xi.eco.AQUAN } } },    -- 75 DMG+3 -> 75 DMG+7
[1854] = { check = checks.checkTrials, reqs = { killWithWs = true, wSkill = set{ xi.weaponskill.CATASTROPHE }, mobSystem = set{ xi.eco.LIZARD } } },   -- 75 DMG+7 -> 75 DMG+9
[1855] = { check = checks.checkTrials, reqs = { killWithWs = true, wSkill = set{ xi.weaponskill.CATASTROPHE }, mobSystem = set{ xi.eco.BIRD } } },     -- 75 DMG+9 -> 80
[2265] = { check = checks.checkTrials, reqs = { killWithWs = true, wSkill = set{ xi.weaponskill.CATASTROPHE }, mobSystem = set{ xi.eco.BEAST } } },    -- 80 -> 85
[2676] = { check = checks.checkTrials, reqs = { mobid = set{ 17326089 } } }, -- 85 -> 90 (Velosareon)
[3109] = { check = checks.checkTrials, reqs = { mobid = set{ 17330206 } } }, -- 90 -> 95 (Animated Scythe)
[3572] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3502 } } }, -- 95 -> 99 (Umbral Marrow x5)
[3622] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3502 } } }, -- 99 -> 99 (Umbral Marrow x250)

-- Kikoku
[1051] = { check = checks.checkTrials, reqs = { killWithWs = false, wSkill = set{ xi.weaponskill.BLADE_METSU }, mobSystem = set{ xi.eco.BIRD } } },    -- 75 -> 75 DMG+1
[1052] = { check = checks.checkTrials, reqs = { killWithWs = true, wSkill = set{ xi.weaponskill.BLADE_METSU }, mobSystem = set{ xi.eco.ARCANA } } },   -- 75 DMG+1 -> 75 DMG+3
[1858] = { check = checks.checkTrials, reqs = { killWithWs = true, wSkill = set{ xi.weaponskill.BLADE_METSU }, mobSystem = set{ xi.eco.AMORPH } } },   -- 75 DMG+3 -> 75 DMG+4
[1859] = { check = checks.checkTrials, reqs = { killWithWs = true, wSkill = set{ xi.weaponskill.BLADE_METSU }, mobSystem = set{ xi.eco.AQUAN } } },    -- 75 DMG+4 -> 80
[2269] = { check = checks.checkTrials, reqs = { killWithWs = true, wSkill = set{ xi.weaponskill.BLADE_METSU }, mobSystem = set{ xi.eco.UNDEAD } } },   -- 80 -> 85
[2680] = { check = checks.checkTrials, reqs = { mobid = set{ 17326088 } } }, -- 85 -> 90 (Mildaunegeux)
[3113] = { check = checks.checkTrials, reqs = { mobid = set{ 17330207 } } }, -- 90 -> 95 (Animated Kunai)
[3576] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3502 } } }, -- 95 -> 99 (Umbral Marrow x5)
[3626] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3502 } } }, -- 99 -> 99 (Umbral Marrow x250)

-- Amanomurakumo
[1057] = { check = checks.checkTrials, reqs = { killWithWs = false, wSkill = set{ xi.weaponskill.TACHI_KAITEN }, mobSystem = set{ xi.eco.BEAST } } },    -- 75 -> 75 DMG+2
[1058] = { check = checks.checkTrials, reqs = { killWithWs = true, wSkill = set{ xi.weaponskill.TACHI_KAITEN }, mobSystem = set{ xi.eco.VERMIN } } },    -- 75 DMG+2 -> 75 DMG+5
[1862] = { check = checks.checkTrials, reqs = { killWithWs = true, wSkill = set{ xi.weaponskill.TACHI_KAITEN }, mobSystem = set{ xi.eco.ARCANA } } },    -- 75 DMG+5 -> 75 DMG+6
[1863] = { check = checks.checkTrials, reqs = { killWithWs = true, wSkill = set{ xi.weaponskill.TACHI_KAITEN }, mobSystem = set{ xi.eco.BIRD } } },      -- 75 DMG+6 -> 80
[2271] = { check = checks.checkTrials, reqs = { killWithWs = true, wSkill = set{ xi.weaponskill.TACHI_KAITEN }, mobSystem = set{ xi.eco.AQUAN } } },     -- 80 -> 85
[2682] = { check = checks.checkTrials, reqs = { mobid = set{ 17326089 } } }, -- 85 -> 90 (Velosareon)
[3115] = { check = checks.checkTrials, reqs = { mobid = set{ 17330208 } } }, -- 90 -> 95 (Animated Tachi)
[3578] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3502 } } }, -- 95 -> 99 (Umbral Marrow x5)
[3628] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3502 } } }, -- 99 -> 99 (Umbral Marrow x250)

-- Mjollnir
[1063] = { check = checks.checkTrials, reqs = { killWithWs = false, wSkill = set{ xi.weaponskill.RANDGRITH }, mobSystem = set{ xi.eco.LIZARD } } },   -- 75 -> 75 DMG+2
[1064] = { check = checks.checkTrials, reqs = { killWithWs = true, wSkill = set{ xi.weaponskill.RANDGRITH }, mobSystem = set{ xi.eco.BEAST } } },     -- 75 DMG+2 -> 75 DMG+8
[1866] = { check = checks.checkTrials, reqs = { killWithWs = true, wSkill = set{ xi.weaponskill.RANDGRITH }, mobSystem = set{ xi.eco.AMORPH } } },    -- 75 DMG+8 -> 75 DMG+9
[1867] = { check = checks.checkTrials, reqs = { killWithWs = true, wSkill = set{ xi.weaponskill.RANDGRITH }, mobSystem = set{ xi.eco.VERMIN } } },    -- 75 DMG+9 -> 80
[2273] = { check = checks.checkTrials, reqs = { killWithWs = true, wSkill = set{ xi.weaponskill.RANDGRITH }, mobSystem = set{ xi.eco.BIRD } } },      -- 80 -> 85
[2684] = { check = checks.checkTrials, reqs = { mobid = set{ 17326087 } } }, -- 85 -> 90 (Quiebitiel)
[3117] = { check = checks.checkTrials, reqs = { mobid = set{ 17330209 } } }, -- 90 -> 95 (Animated Tachi)
[3581] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3502 } } }, -- 95 -> 99 (Umbral Marrow x5)
[3630] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3502 } } }, -- 99 -> 99 (Umbral Marrow x250)

-- Claustrum
[1069] = { check = checks.checkTrials, reqs = { killWithWs = false, wSkill = set{ xi.weaponskill.GATE_OF_TARTARUS }, mobSystem = set{ xi.eco.AQUAN } } },   -- 75 -> 75 DMG+4
[1070] = { check = checks.checkTrials, reqs = { killWithWs = true, wSkill = set{ xi.weaponskill.GATE_OF_TARTARUS }, mobSystem = set{ xi.eco.LIZARD } } },   -- 75 DMG+4 -> 75 DMG+10
[1870] = { check = checks.checkTrials, reqs = { killWithWs = true, wSkill = set{ xi.weaponskill.GATE_OF_TARTARUS }, mobSystem = set{ xi.eco.UNDEAD } } },   -- 75 DMG+10 -> 75 DMG+12
[1871] = { check = checks.checkTrials, reqs = { killWithWs = true, wSkill = set{ xi.weaponskill.GATE_OF_TARTARUS }, mobSystem = set{ xi.eco.BEAST } } },    -- 75 DMG+12 -> 80
[2275] = { check = checks.checkTrials, reqs = { killWithWs = true, wSkill = set{ xi.weaponskill.GATE_OF_TARTARUS }, mobSystem = set{ xi.eco.PLANTOID } } }, -- 80 -> 85
[2686] = { check = checks.checkTrials, reqs = { mobid = set{ 17326090 } } }, -- 85 -> 90 (Dagourmarche)
[3119] = { check = checks.checkTrials, reqs = { mobid = set{ 17330210 } } }, -- 90 -> 95 (Animated Staff)
[3582] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3502 } } }, -- 95 -> 99 (Umbral Marrow x5)
[3632] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3502 } } }, -- 99 -> 99 (Umbral Marrow x250)

-- Annihilator
[1081] = { check = checks.checkTrials, reqs = { killWithWs = false, wSkill = set{ xi.weaponskill.CORONACH }, mobSystem = set{ xi.eco.BEAST } } },    -- 75 -> 75 DMG+2
[1082] = { check = checks.checkTrials, reqs = { killWithWs = true, wSkill = set{ xi.weaponskill.CORONACH }, mobSystem = set{ xi.eco.AQUAN } } },     -- 75 DMG+2 -> 75 DMG+6
[1878] = { check = checks.checkTrials, reqs = { killWithWs = true, wSkill = set{ xi.weaponskill.CORONACH }, mobSystem = set{ xi.eco.ARCANA } } },    -- 75 DMG+6 -> 75 DMG+8
[1879] = { check = checks.checkTrials, reqs = { killWithWs = true, wSkill = set{ xi.weaponskill.CORONACH }, mobSystem = set{ xi.eco.PLANTOID } } },  -- 75 DMG+8 -> 80
[2280] = { check = checks.checkTrials, reqs = { killWithWs = true, wSkill = set{ xi.weaponskill.CORONACH }, mobSystem = set{ xi.eco.UNDEAD } } },    -- 80 -> 85
[2691] = { check = checks.checkTrials, reqs = { mobid = set{ 17326088 } } }, -- 85 -> 90 (Mildaunegeux)
[3124] = { check = checks.checkTrials, reqs = { mobid = set{ 17330212 } } }, -- 90 -> 95 (Animated Gun)
[3587] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3502 } } }, -- 95 -> 99 (Umbral Marrow x5)
[3637] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3502 } } }, -- 99 -> 99 (Umbral Marrow x250)

-- Yoichinoyumi
[1090] = { check = checks.checkTrials, reqs = { killWithWs = false, wSkill = set{ xi.weaponskill.NAMAS_ARROW }, mobSystem = set{ xi.eco.AMORPH } } },   -- 75 -> 75 DMG+2
[1091] = { check = checks.checkTrials, reqs = { killWithWs = true, wSkill = set{ xi.weaponskill.NAMAS_ARROW }, mobSystem = set{ xi.eco.BEAST } } },     -- 75 DMG+2 -> 75 DMG+5
[1884] = { check = checks.checkTrials, reqs = { killWithWs = true, wSkill = set{ xi.weaponskill.NAMAS_ARROW }, mobSystem = set{ xi.eco.LIZARD } } },    -- 75 DMG+5 -> 75 DMG+8
[1885] = { check = checks.checkTrials, reqs = { killWithWs = true, wSkill = set{ xi.weaponskill.NAMAS_ARROW }, mobSystem = set{ xi.eco.AQUAN } } },     -- 75 DMG+8 -> 80
[2279] = { check = checks.checkTrials, reqs = { killWithWs = true, wSkill = set{ xi.weaponskill.NAMAS_ARROW }, mobSystem = set{ xi.eco.VERMIN } } },    -- 80 -> 85
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

-- Relic Armor | NQ = 0 -> +2 | HQ = +1 -> +2
-- Bard
--- Head
[4744] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3493 } } }, -- NQ Forgotten Thoughts x50
[4745] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3493 } } }, -- HQ Forgotten Thoughts x30
--- Body
[4746] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3494 } } }, -- NQ Forgotten Hopes x50
[4747] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3494 } } }, -- HQ Forgotten Hopes x30
--- Hand
[4748] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3495 } } }, -- NQ Forgotten Touches x50
[4749] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3495 } } }, -- HQ Forgotten Touches x30
--- Leg
[4750] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3496 } } }, -- NQ Forgotten Journeys x50
[4751] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3496 } } }, -- HQ Forgotten Journeys x30
--- Feet
[4752] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3497 } } }, -- NQ Forgotten Steps x50
[4753] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3497 } } }, -- HQ Forgotten Steps x30

-- Beastmaster
--- Head
[4734] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3493 } } }, -- NQ Forgotten Thoughts x50
[4735] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3493 } } }, -- HQ Forgotten Thoughts x30
--- Body
[4736] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3494 } } }, -- NQ Forgotten Hopes x50
[4737] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3494 } } }, -- HQ Forgotten Hopes x30
--- Hand
[4738] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3495 } } }, -- NQ Forgotten Touches x50
[4739] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3495 } } }, -- HQ Forgotten Touches x30
--- Leg
[4740] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3496 } } }, -- NQ Forgotten Journeys x50
[4741] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3496 } } }, -- HQ Forgotten Journeys x30
--- Feet
[4742] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3497 } } }, -- NQ Forgotten Steps x50
[4743] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3497 } } }, -- HQ Forgotten Steps x30

-- Black Mage
--- Head
[4684] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3493 } } }, -- NQ Forgotten Thoughts x50
[4685] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3493 } } }, -- HQ Forgotten Thoughts x30
--- Body
[4686] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3494 } } }, -- NQ Forgotten Hopes x50
[4687] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3494 } } }, -- HQ Forgotten Hopes x30
--- Hand
[4688] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3495 } } }, -- NQ Forgotten Touches x50
[4689] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3495 } } }, -- HQ Forgotten Touches x30
--- Leg
[4690] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3496 } } }, -- NQ Forgotten Journeys x50
[4691] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3496 } } }, -- HQ Forgotten Journeys x30
--- Feet
[4692] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3497 } } }, -- NQ Forgotten Steps x50
[4693] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3497 } } }, -- HQ Forgotten Steps x30

-- Blue Mage
--- Head
[4804] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3493 } } }, -- NQ Forgotten Thoughts x50
[4805] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3493 } } }, -- HQ Forgotten Thoughts x30
--- Body
[4806] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3494 } } }, -- NQ Forgotten Hopes x50
[4807] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3494 } } }, -- HQ Forgotten Hopes x30
--- Hand
[4808] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3495 } } }, -- NQ Forgotten Touches x50
[4809] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3495 } } }, -- HQ Forgotten Touches x30
--- Leg
[4810] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3496 } } }, -- NQ Forgotten Journeys x50
[4811] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3496 } } }, -- HQ Forgotten Journeys x30
--- Feet
[4812] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3497 } } }, -- NQ Forgotten Steps x50
[4813] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3497 } } }, -- HQ Forgotten Steps x30

-- Corsair
--- Head
[4814] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3493 } } }, -- NQ Forgotten Thoughts x50
[4815] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3493 } } }, -- HQ Forgotten Thoughts x30
--- Body
[4816] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3494 } } }, -- NQ Forgotten Hopes x50
[4817] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3494 } } }, -- HQ Forgotten Hopes x30
--- Hand
[4818] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3495 } } }, -- NQ Forgotten Touches x50
[4819] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3495 } } }, -- HQ Forgotten Touches x30
--- Leg
[4820] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3496 } } }, -- NQ Forgotten Journeys x50
[4821] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3496 } } }, -- HQ Forgotten Journeys x30
--- Feet
[4822] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3497 } } }, -- NQ Forgotten Steps x50
[4823] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3497 } } }, -- HQ Forgotten Steps x30

-- Dancer
--- Head
[4834] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3493 } } }, -- NQ Forgotten Thoughts x50
[4835] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3493 } } }, -- HQ Forgotten Thoughts x30
--- Body
[4836] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3494 } } }, -- NQ Forgotten Hopes x50
[4837] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3494 } } }, -- HQ Forgotten Hopes x30
--- Hand
[4838] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3495 } } }, -- NQ Forgotten Touches x50
[4839] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3495 } } }, -- HQ Forgotten Touches x30
--- Leg
[4840] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3496 } } }, -- NQ Forgotten Journeys x50
[4841] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3496 } } }, -- HQ Forgotten Journeys x30
--- Feet
[4842] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3497 } } }, -- NQ Forgotten Steps x50
[4843] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3497 } } }, -- HQ Forgotten Steps x30

-- Dark Knight
--- Head
[4724] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3493 } } }, -- NQ Forgotten Thoughts x50
[4725] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3493 } } }, -- HQ Forgotten Thoughts x30
--- Body
[4726] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3494 } } }, -- NQ Forgotten Hopes x50
[4727] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3494 } } }, -- HQ Forgotten Hopes x30
--- Hand
[4728] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3495 } } }, -- NQ Forgotten Touches x50
[4729] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3495 } } }, -- HQ Forgotten Touches x30
--- Leg
[4730] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3496 } } }, -- NQ Forgotten Journeys x50
[4731] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3496 } } }, -- HQ Forgotten Journeys x30
--- Feet
[4732] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3497 } } }, -- NQ Forgotten Steps x50
[4733] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3497 } } }, -- HQ Forgotten Steps x30

-- Dragoon
--- Head
[4784] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3493 } } }, -- NQ Forgotten Thoughts x50
[4785] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3493 } } }, -- HQ Forgotten Thoughts x30
--- Body
[4786] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3494 } } }, -- NQ Forgotten Hopes x50
[4787] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3494 } } }, -- HQ Forgotten Hopes x30
--- Hand
[4788] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3495 } } }, -- NQ Forgotten Touches x50
[4789] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3495 } } }, -- HQ Forgotten Touches x30
--- Leg
[4790] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3496 } } }, -- NQ Forgotten Journeys x50
[4791] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3496 } } }, -- HQ Forgotten Journeys x30
--- Feet
[4792] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3497 } } }, -- NQ Forgotten Steps x50
[4793] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3497 } } }, -- HQ Forgotten Steps x30

-- Monk
--- Head
[4664] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3493 } } }, -- NQ Forgotten Thoughts x50
[4665] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3493 } } }, -- HQ Forgotten Thoughts x30
--- Body
[4666] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3494 } } }, -- NQ Forgotten Hopes x50
[4667] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3494 } } }, -- HQ Forgotten Hopes x30
--- Hand
[4668] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3495 } } }, -- NQ Forgotten Touches x50
[4669] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3495 } } }, -- HQ Forgotten Touches x30
--- Leg
[4670] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3496 } } }, -- NQ Forgotten Journeys x50
[4671] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3496 } } }, -- HQ Forgotten Journeys x30
--- Feet
[4672] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3497 } } }, -- NQ Forgotten Steps x50
[4673] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3497 } } }, -- HQ Forgotten Steps x30

-- Ninja
--- Head
[4774] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3493 } } }, -- NQ Forgotten Thoughts x50
[4775] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3493 } } }, -- HQ Forgotten Thoughts x30
--- Body
[4776] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3494 } } }, -- NQ Forgotten Hopes x50
[4777] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3494 } } }, -- HQ Forgotten Hopes x30
--- Hand
[4778] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3495 } } }, -- NQ Forgotten Touches x50
[4779] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3495 } } }, -- HQ Forgotten Touches x30
--- Leg
[4780] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3496 } } }, -- NQ Forgotten Journeys x50
[4781] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3496 } } }, -- HQ Forgotten Journeys x30
--- Feet
[4782] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3497 } } }, -- NQ Forgotten Steps x50
[4783] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3497 } } }, -- HQ Forgotten Steps x30

-- Paladin
--- Head
[4714] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3493 } } }, -- NQ Forgotten Thoughts x50
[4715] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3493 } } }, -- HQ Forgotten Thoughts x30
--- Body
[4716] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3494 } } }, -- NQ Forgotten Hopes x50
[4717] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3494 } } }, -- HQ Forgotten Hopes x30
--- Hand
[4718] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3495 } } }, -- NQ Forgotten Touches x50
[4719] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3495 } } }, -- HQ Forgotten Touches x30
--- Leg
[4720] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3496 } } }, -- NQ Forgotten Journeys x50
[4721] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3496 } } }, -- HQ Forgotten Journeys x30
--- Feet
[4722] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3497 } } }, -- NQ Forgotten Steps x50
[4723] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3497 } } }, -- HQ Forgotten Steps x30

-- Puppetmaster
--- Head
[4824] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3493 } } }, -- NQ Forgotten Thoughts x50
[4825] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3493 } } }, -- HQ Forgotten Thoughts x30
--- Body
[4826] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3494 } } }, -- NQ Forgotten Hopes x50
[4827] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3494 } } }, -- HQ Forgotten Hopes x30
--- Hand
[4828] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3495 } } }, -- NQ Forgotten Touches x50
[4829] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3495 } } }, -- HQ Forgotten Touches x30
--- Leg
[4830] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3496 } } }, -- NQ Forgotten Journeys x50
[4831] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3496 } } }, -- HQ Forgotten Journeys x30
--- Feet
[4832] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3497 } } }, -- NQ Forgotten Steps x50
[4833] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3497 } } }, -- HQ Forgotten Steps x30

-- Ranger
--- Head
[4754] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3493 } } }, -- NQ Forgotten Thoughts x50
[4755] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3493 } } }, -- HQ Forgotten Thoughts x30
--- Body
[4756] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3494 } } }, -- NQ Forgotten Hopes x50
[4757] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3494 } } }, -- HQ Forgotten Hopes x30
--- Hand
[4758] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3495 } } }, -- NQ Forgotten Touches x50
[4759] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3495 } } }, -- HQ Forgotten Touches x30
--- Leg
[4760] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3496 } } }, -- NQ Forgotten Journeys x50
[4761] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3496 } } }, -- HQ Forgotten Journeys x30
--- Feet
[4762] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3497 } } }, -- NQ Forgotten Steps x50
[4763] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3497 } } }, -- HQ Forgotten Steps x30

-- Red Mage
--- Head
[4694] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3493 } } }, -- NQ Forgotten Thoughts x50
[4695] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3493 } } }, -- HQ Forgotten Thoughts x30
--- Body
[4696] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3494 } } }, -- NQ Forgotten Hopes x50
[4697] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3494 } } }, -- HQ Forgotten Hopes x30
--- Hand
[4698] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3495 } } }, -- NQ Forgotten Touches x50
[4699] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3495 } } }, -- HQ Forgotten Touches x30
--- Leg
[4700] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3496 } } }, -- NQ Forgotten Journeys x50
[4701] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3496 } } }, -- HQ Forgotten Journeys x30
--- Feet
[4702] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3497 } } }, -- NQ Forgotten Steps x50
[4703] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3497 } } }, -- HQ Forgotten Steps x30

-- Samurai
--- Head
[4764] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3493 } } }, -- NQ Forgotten Thoughts x50
[4765] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3493 } } }, -- HQ Forgotten Thoughts x30
--- Body
[4766] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3494 } } }, -- NQ Forgotten Hopes x50
[4767] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3494 } } }, -- HQ Forgotten Hopes x30
--- Hand
[4768] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3495 } } }, -- NQ Forgotten Touches x50
[4769] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3495 } } }, -- HQ Forgotten Touches x30
--- Leg
[4770] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3496 } } }, -- NQ Forgotten Journeys x50
[4771] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3496 } } }, -- HQ Forgotten Journeys x30
--- Feet
[4772] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3497 } } }, -- NQ Forgotten Steps x50
[4773] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3497 } } }, -- HQ Forgotten Steps x30

-- Scholar
--- Head
[4844] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3493 } } }, -- NQ Forgotten Thoughts x50
[4845] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3493 } } }, -- HQ Forgotten Thoughts x30
--- Body
[4846] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3494 } } }, -- NQ Forgotten Hopes x50
[4847] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3494 } } }, -- HQ Forgotten Hopes x30
--- Hand
[4848] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3495 } } }, -- NQ Forgotten Touches x50
[4849] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3495 } } }, -- HQ Forgotten Touches x30
--- Leg
[4850] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3496 } } }, -- NQ Forgotten Journeys x50
[4851] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3496 } } }, -- HQ Forgotten Journeys x30
--- Feet
[4852] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3497 } } }, -- NQ Forgotten Steps x50
[4853] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3497 } } }, -- HQ Forgotten Steps x30

-- Summoner
--- Head
[4794] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3493 } } }, -- NQ Forgotten Thoughts x50
[4795] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3493 } } }, -- HQ Forgotten Thoughts x30
--- Body
[4796] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3494 } } }, -- NQ Forgotten Hopes x50
[4797] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3494 } } }, -- HQ Forgotten Hopes x30
--- Hand
[4798] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3495 } } }, -- NQ Forgotten Touches x50
[4799] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3495 } } }, -- HQ Forgotten Touches x30
--- Leg
[4800] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3496 } } }, -- NQ Forgotten Journeys x50
[4801] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3496 } } }, -- HQ Forgotten Journeys x30
--- Feet
[4802] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3497 } } }, -- NQ Forgotten Steps x50
[4803] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3497 } } }, -- HQ Forgotten Steps x30

-- Thief
--- Head
[4704] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3493 } } }, -- NQ Forgotten Thoughts x50
[4705] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3493 } } }, -- HQ Forgotten Thoughts x30
--- Body
[4706] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3494 } } }, -- NQ Forgotten Hopes x50
[4707] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3494 } } }, -- HQ Forgotten Hopes x30
--- Hand
[4708] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3495 } } }, -- NQ Forgotten Touches x50
[4709] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3495 } } }, -- HQ Forgotten Touches x30
--- Leg
[4710] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3496 } } }, -- NQ Forgotten Journeys x50
[4711] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3496 } } }, -- HQ Forgotten Journeys x30
--- Feet
[4712] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3497 } } }, -- NQ Forgotten Steps x50
[4713] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3497 } } }, -- HQ Forgotten Steps x30

-- Warrior
--- Head
[4654] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3493 } } }, -- NQ Forgotten Thoughts x50
[4655] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3493 } } }, -- HQ Forgotten Thoughts x30
--- Body
[4656] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3494 } } }, -- NQ Forgotten Hopes x50
[4657] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3494 } } }, -- HQ Forgotten Hopes x30
--- Hand
[4658] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3495 } } }, -- NQ Forgotten Touches x50
[4659] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3495 } } }, -- HQ Forgotten Touches x30
--- Leg
[4660] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3496 } } }, -- NQ Forgotten Journeys x50
[4661] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3496 } } }, -- HQ Forgotten Journeys x30
--- Feet
[4662] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3497 } } }, -- NQ Forgotten Steps x50
[4663] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3497 } } }, -- HQ Forgotten Steps x30

-- White Mage
--- Head
[4674] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3493 } } }, -- NQ Forgotten Thoughts x50
[4675] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3493 } } }, -- HQ Forgotten Thoughts x30
--- Body
[4676] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3494 } } }, -- NQ Forgotten Hopes x50
[4677] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3494 } } }, -- HQ Forgotten Hopes x30
--- Hand
[4678] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3495 } } }, -- NQ Forgotten Touches x50
[4679] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3495 } } }, -- HQ Forgotten Touches x30
--- Leg
[4680] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3496 } } }, -- NQ Forgotten Journeys x50
[4681] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3496 } } }, -- HQ Forgotten Journeys x30
--- Feet
[4682] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3497 } } }, -- NQ Forgotten Steps x50
[4683] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3497 } } }, -- HQ Forgotten Steps x30

-- Abyssean Armor
-- Warrior
[4156] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3110 } } }, -- 0 -> +1 (Rvg. Seal: Hd.)
[4336] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3130 } } }, -- 0 -> +1 (Rvg. Seal: Bd.)
[4316] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3150 } } }, -- 0 -> +1 (Rvg. Seal: Hn.)
[4176] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3170 } } }, -- 0 -> +1 (Rvg. Seal: Lg.)
[4196] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3190 } } }, -- 0 -> +1 (Rvg. Seal: Ft.)
[4216] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3210 } } }, -- +1 -> +2 (Stone of Vision)
[4376] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3214 } } }, -- +1 -> +2 (Stone of Ardor)
[4356] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3218 } } }, -- +1 -> +2 (Stone of Wieldance)
[4236] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3222 } } }, -- +1 -> +2 (Stone of Balance)
[4256] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3226 } } }, -- +1 -> +2 (Stone of Voyage)

-- Monk
[4157] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3111 } } }, -- 0 -> +1 (Tantra Seal: Hd.)
[4337] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3131 } } }, -- 0 -> +1 (Tantra Seal: Bd.)
[4317] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3151 } } }, -- 0 -> +1 (Tantra Seal: Hn.)
[4177] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3171 } } }, -- 0 -> +1 (Tantra Seal: Lg.)
[4197] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3191 } } }, -- 0 -> +1 (Tantra Seal: Ft.)
[4217] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3212 } } }, -- +1 -> +2 (Jewel of Vision)
[4377] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3217 } } }, -- +1 -> +2 (Card of Ardor)
[4357] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3220 } } }, -- +1 -> +2 (Jewel of Wieldance)
[4237] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3224 } } }, -- +1 -> +2 (Jewel of Balance)
[4257] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3227 } } }, -- +1 -> +2 (Coin of Voyage)

-- White Mage
[4158] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3112 } } }, -- 0 -> +1 (Orison Seal: Hd.)
[4338] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3132 } } }, -- 0 -> +1 (Orison Seal: Bd.)
[4318] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3152 } } }, -- 0 -> +1 (Orison Seal: Hn.)
[4178] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3172 } } }, -- 0 -> +1 (Orison Seal: Lg.)
[4198] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3192 } } }, -- 0 -> +1 (Orison Seal: Ft.)
[4218] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3210 } } }, -- +1 -> +2 (Stone of Vision)
[4378] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3217 } } }, -- +1 -> +2 (Card of Ardor)
[4358] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3219 } } }, -- +1 -> +2 (Coin of Wieldance)
[4238] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3225 } } }, -- +1 -> +2 (Card of Balance)
[4258] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3228 } } }, -- +1 -> +2 (Jewel of Voyage)

-- Black Mage
[4159] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3113 } } }, -- 0 -> +1 (Goetia Seal: Hd.)
[4339] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3133 } } }, -- 0 -> +1 (Goetia Seal: Bd.)
[4319] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3153 } } }, -- 0 -> +1 (Goetia Seal: Hn.)
[4179] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3173 } } }, -- 0 -> +1 (Goetia Seal: Lg.)
[4199] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3193 } } }, -- 0 -> +1 (Goetia Seal: Ft.)
[4219] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3211 } } }, -- +1 -> +2 (Coin of Vision)
[4379] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3216 } } }, -- +1 -> +2 (Jewel of Ardor)
[4359] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3220 } } }, -- +1 -> +2 (Jewel of Wieldance)
[4239] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3222 } } }, -- +1 -> +2 (Stone of Balance)
[4259] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3229 } } }, -- +1 -> +2 (Card of Voyage)

-- Red Mage
[4160] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3114 } } }, -- 0 -> +1 (Estoqueur's Seal: Hd.)
[4340] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3134 } } }, -- 0 -> +1 (Estoqueur's Seal: Bd.)
[4320] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3154 } } }, -- 0 -> +1 (Estoqueur's Seal: Hn.)
[4180] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3174 } } }, -- 0 -> +1 (Estoqueur's Seal: Lg.)
[4200] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3194 } } }, -- 0 -> +1 (Estoqueur's Seal: Ft.)
[4220] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3212 } } }, -- +1 -> +2 (Jewel of Vision)
[4380] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3216 } } }, -- +1 -> +2 (Jewel of Ardor)
[4360] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3218 } } }, -- +1 -> +2 (Stone of Wieldance)
[4240] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3223 } } }, -- +1 -> +2 (Coin of Balance)
[4260] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3226 } } }, -- +1 -> +2 (Stone of Voyage)

-- Thief
[4161] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3115 } } }, -- 0 -> +1 (Raider's Seal: Hd.)
[4341] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3135 } } }, -- 0 -> +1 (Raider's Seal: Bd.)
[4321] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3155 } } }, -- 0 -> +1 (Raider's Seal: Hn.)
[4181] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3175 } } }, -- 0 -> +1 (Raider's Seal: Lg.)
[4201] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3195 } } }, -- 0 -> +1 (Raider's Seal: Ft.)
[4221] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3210 } } }, -- +1 -> +2 (Stone of Vision)
[4381] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3215 } } }, -- +1 -> +2 (Coin of Ardor)
[4361] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3218 } } }, -- +1 -> +2 (Stone of Wieldance)
[4241] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3223 } } }, -- +1 -> +2 (Coin of Balance)
[4261] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3228 } } }, -- +1 -> +2 (Jewel of Voyage)

-- Paladin
[4162] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3116 } } }, -- 0 -> +1 (Creed Seal: Hd.)
[4342] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3136 } } }, -- 0 -> +1 (Creed Seal: Bd.)
[4322] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3156 } } }, -- 0 -> +1 (Creed Seal: Hn.)
[4182] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3176 } } }, -- 0 -> +1 (Creed Seal: Lg.)
[4202] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3196 } } }, -- 0 -> +1 (Creed Seal: Ft.)
[4222] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3213 } } }, -- +1 -> +2 (Card of Vision)
[4382] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3214 } } }, -- +1 -> +2 (Stone of Ardor)
[4362] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3221 } } }, -- +1 -> +2 (Card of Wieldance)
[4242] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3223 } } }, -- +1 -> +2 (Coin of Balance)
[4262] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3226 } } }, -- +1 -> +2 (Stone of Voyage)

-- Dark Knight
[4163] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3117 } } }, -- 0 -> +1 (Bale Seal: Hd.)
[4343] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3137 } } }, -- 0 -> +1 (Bale Seal: Bd.)
[4323] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3157 } } }, -- 0 -> +1 (Bale Seal: Hn.)
[4183] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3177 } } }, -- 0 -> +1 (Bale Seal: Lg.)
[4203] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3197 } } }, -- 0 -> +1 (Bale Seal: Ft.)
[4223] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3211 } } }, -- +1 -> +2 (Coin of Vision)
[4383] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3215 } } }, -- +1 -> +2 (Coin of Ardor)
[4363] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3219 } } }, -- +1 -> +2 (Coin of Wieldance)
[4243] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3223 } } }, -- +1 -> +2 (Coin of Balance)
[4263] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3227 } } }, -- +1 -> +2 (Coin of Voyage)

-- Beastmaster
[4164] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3118 } } }, -- 0 -> +1 (Ferine Seal: Hd.)
[4344] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3138 } } }, -- 0 -> +1 (Ferine Seal: Bd.)
[4324] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3158 } } }, -- 0 -> +1 (Ferine Seal: Hn.)
[4184] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3178 } } }, -- 0 -> +1 (Ferine Seal: Lg.)
[4204] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3198 } } }, -- 0 -> +1 (Ferine Seal: Ft.)
[4224] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3211 } } }, -- +1 -> +2 (Coin of Vision)
[4384] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3217 } } }, -- +1 -> +2 (Card of Ardor)
[4364] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3218 } } }, -- +1 -> +2 (Stone of Wieldance)
[4244] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3224 } } }, -- +1 -> +2 (Jewel of Balance)
[4264] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3229 } } }, -- +1 -> +2 (Card of Voyage)

-- Bard
[4165] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3119 } } }, -- 0 -> +1 (Aoidos' Seal: Hd.)
[4345] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3139 } } }, -- 0 -> +1 (Aoidos' Seal: Bd.)
[4325] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3159 } } }, -- 0 -> +1 (Aoidos' Seal: Hn.)
[4185] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3179 } } }, -- 0 -> +1 (Aoidos' Seal: Lg.)
[4205] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3199 } } }, -- 0 -> +1 (Aoidos' Seal: Ft.)
[4225] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3210 } } }, -- +1 -> +2 (Stone of Vision)
[4385] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3214 } } }, -- +1 -> +2 (Stone of Ardor)
[4365] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3220 } } }, -- +1 -> +2 (Jewel of Wieldance)
[4245] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3223 } } }, -- +1 -> +2 (Coin of Balance)
[4265] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3228 } } }, -- +1 -> +2 (Jewel of Voyage)

-- Ranger
[4166] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3120 } } }, -- 0 -> +1 (Sylvan Seal: Hd.)
[4346] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3140 } } }, -- 0 -> +1 (Sylvan Seal: Bd.)
[4326] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3160 } } }, -- 0 -> +1 (Sylvan Seal: Hn.)
[4186] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3180 } } }, -- 0 -> +1 (Sylvan Seal: Lg.)
[4206] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3200 } } }, -- 0 -> +1 (Sylvan Seal: Ft.)
[4226] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3210 } } }, -- +1 -> +2 (Stone of Vision)
[4386] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3215 } } }, -- +1 -> +2 (Coin of Ardor)
[4366] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3219 } } }, -- +1 -> +2 (Coin of Wieldance)
[4246] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3224 } } }, -- +1 -> +2 (Jewel of Balance)
[4266] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3229 } } }, -- +1 -> +2 (Card of Voyage)

-- Samurai
[4167] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3121 } } }, -- 0 -> +1 (Unkai Seal: Hd.)
[4347] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3141 } } }, -- 0 -> +1 (Unkai Seal: Bd.)
[4327] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3161 } } }, -- 0 -> +1 (Unkai Seal: Hn.)
[4187] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3181 } } }, -- 0 -> +1 (Unkai Seal: Lg.)
[4207] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3201 } } }, -- 0 -> +1 (Unkai Seal: Ft.)
[4227] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3212 } } }, -- +1 -> +2 (Jewel of Vision)
[4387] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3216 } } }, -- +1 -> +2 (Jewel of Ardor)
[4367] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3220 } } }, -- +1 -> +2 (Jewel of Wieldance)
[4247] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3224 } } }, -- +1 -> +2 (Jewel of Balance)
[4267] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3228 } } }, -- +1 -> +2 (Jewel of Voyage)

-- Ninja
[4168] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3122 } } }, -- 0 -> +1 (Iga Seal: Hd.)
[4348] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3142 } } }, -- 0 -> +1 (Iga Seal: Bd.)
[4328] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3162 } } }, -- 0 -> +1 (Iga Seal: Hn.)
[4188] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3182 } } }, -- 0 -> +1 (Iga Seal: Lg.)
[4208] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3202 } } }, -- 0 -> +1 (Iga Seal: Ft.)
[4228] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3211 } } }, -- +1 -> +2 (Coin of Vision)
[4388] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3214 } } }, -- +1 -> +2 (Stone of Ardor)
[4368] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3221 } } }, -- +1 -> +2 (Card of Wieldance)
[4248] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3222 } } }, -- +1 -> +2 (Stone of Balance)
[4268] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3229 } } }, -- +1 -> +2 (Card of Voyage)

-- Dragoon
[4169] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3123 } } }, -- 0 -> +1 (Lancer's Seal: Hd.)
[4349] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3143 } } }, -- 0 -> +1 (Lancer's Seal: Bd.)
[4329] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3163 } } }, -- 0 -> +1 (Lancer's Seal: Hn.)
[4189] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3183 } } }, -- 0 -> +1 (Lancer's Seal: Lg.)
[4209] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3203 } } }, -- 0 -> +1 (Lancer's Seal: Ft.)
[4229] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3213 } } }, -- +1 -> +2 (Card of Vision)
[4389] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3217 } } }, -- +1 -> +2 (Card of Ardor)
[4369] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3221 } } }, -- +1 -> +2 (Card of Wieldance)
[4249] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3225 } } }, -- +1 -> +2 (Card of Balance)
[4269] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3229 } } }, -- +1 -> +2 (Card of Voyage)

-- Summoner
[4170] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3124 } } }, -- 0 -> +1 (Caller's Seal: Hd.)
[4350] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3144 } } }, -- 0 -> +1 (Caller's Seal: Bd.)
[4330] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3164 } } }, -- 0 -> +1 (Caller's Seal: Hn.)
[4190] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3184 } } }, -- 0 -> +1 (Caller's Seal: Lg.)
[4210] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3204 } } }, -- 0 -> +1 (Caller's Seal: Ft.)
[4230] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3211 } } }, -- +1 -> +2 (Coin of Vision)
[4390] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3215 } } }, -- +1 -> +2 (Coin of Ardor)
[4370] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3220 } } }, -- +1 -> +2 (Jewel of Wieldance)
[4250] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3225 } } }, -- +1 -> +2 (Card of Balance)
[4270] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3226 } } }, -- +1 -> +2 (Stone of Voyage)

-- Blue Mage
[4171] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3125 } } }, -- 0 -> +1 (Mavi Seal: Hd.)
[4351] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3145 } } }, -- 0 -> +1 (Mavi Seal: Bd.)
[4331] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3165 } } }, -- 0 -> +1 (Mavi Seal: Hn.)
[4191] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3185 } } }, -- 0 -> +1 (Mavi Seal: Lg.)
[4211] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3205 } } }, -- 0 -> +1 (Mavi Seal: Ft.)
[4231] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3213 } } }, -- +1 -> +2 (Card of Vision)
[4391] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3214 } } }, -- +1 -> +2 (Stone of Ardor)
[4371] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3219 } } }, -- +1 -> +2 (Coin of Wieldance)
[4251] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3222 } } }, -- +1 -> +2 (Stone of Balance)
[4271] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3227 } } }, -- +1 -> +2 (Coin of Voyage)

-- Corsair
[4172] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3126 } } }, -- 0 -> +1 (Navarch's Seal: Hd.)
[4352] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3146 } } }, -- 0 -> +1 (Navarch's Seal: Bd.)
[4332] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3166 } } }, -- 0 -> +1 (Navarch's Seal: Hn.)
[4192] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3186 } } }, -- 0 -> +1 (Navarch's Seal: Lg.)
[4212] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3206 } } }, -- 0 -> +1 (Navarch's Seal: Ft.)
[4232] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3212 } } }, -- +1 -> +2 (Jewel of Vision)
[4392] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3215 } } }, -- +1 -> +2 (Coin of Ardor)
[4372] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3221 } } }, -- +1 -> +2 (Card of Wieldance)
[4252] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3225 } } }, -- +1 -> +2 (Card of Balance)
[4272] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3227 } } }, -- +1 -> +2 (Coin of Voyage)

-- Puppetmaster
[4173] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3127 } } }, -- 0 -> +1 (Cirque Seal: Hd.)
[4353] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3147 } } }, -- 0 -> +1 (Cirque Seal: Bd.)
[4333] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3167 } } }, -- 0 -> +1 (Cirque Seal: Hn.)
[4193] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3187 } } }, -- 0 -> +1 (Cirque Seal: Lg.)
[4213] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3207 } } }, -- 0 -> +1 (Cirque Seal: Ft.)
[4233] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3212 } } }, -- +1 -> +2 (Jewel of Vision)
[4393] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3216 } } }, -- +1 -> +2 (Jewel of Ardor)
[4373] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3221 } } }, -- +1 -> +2 (Card of Wieldance)
[4253] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3222 } } }, -- +1 -> +2 (Stone of Balance)
[4273] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3228 } } }, -- +1 -> +2 (Jewel of Voyage)

-- Dancer
[4174] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3128 } } }, -- 0 -> +1 (Charis Seal: Hd.)
[4354] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3148 } } }, -- 0 -> +1 (Charis Seal: Bd.)
[4334] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3168 } } }, -- 0 -> +1 (Charis Seal: Hn.)
[4194] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3188 } } }, -- 0 -> +1 (Charis Seal: Lg.)
[4214] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3208 } } }, -- 0 -> +1 (Charis Seal: Ft.)
[4234] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3213 } } }, -- +1 -> +2 (Card of Vision)
[4394] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3216 } } }, -- +1 -> +2 (Jewel of Ardor)
[4374] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3219 } } }, -- +1 -> +2 (Coin of Wieldance)
[4254] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3225 } } }, -- +1 -> +2 (Card of Balance)
[4274] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3226 } } }, -- +1 -> +2 (Stone of Voyage)

-- Scholar
[4175] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3129 } } }, -- 0 -> +1 (Savant's Seal: Hd.)
[4355] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3149 } } }, -- 0 -> +1 (Savant's Seal: Bd.)
[4335] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3169 } } }, -- 0 -> +1 (Savant's Seal: Hn.)
[4195] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3189 } } }, -- 0 -> +1 (Savant's Seal: Lg.)
[4215] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3209 } } }, -- 0 -> +1 (Savant's Seal: Ft.)
[4235] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3213 } } }, -- +1 -> +2 (Card of Vision)
[4395] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3217 } } }, -- +1 -> +2 (Card of Ardor)
[4375] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3218 } } }, -- +1 -> +2 (Stone of Wieldance)
[4255] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3224 } } }, -- +1 -> +2 (Jewel of Balance)
[4275] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3227 } } }, -- +1 -> +2 (Coin of Voyage)
}
