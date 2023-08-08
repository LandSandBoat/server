-----------------------------------
-- Magian Trial Objectives
-----------------------------------
require('scripts/globals/weaponskillids')
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
    return reqs.mobSystem and params.mob and reqs.wSkill and reqs.mobSystem[params.mob:getEcosystem()] and reqs.wSkill[params.wSkillId] and 1 or 0
end

checks.checkWsKill = function(reqs, params)
    return reqs.mobSystem and params.mob and reqs.wSkill and reqs.mobSystem[params.mob:getEcosystem()] and reqs.wSkill[params.wSkillId] and params.mob:isDead() and 1 or 0
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

xi.magian.trialsold =
{
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

    -- Empyrean Armor
    -- Warrior
    [4376] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3214 } } }, -- +1 -> +2 (Stone of Ardor)
    [4356] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3218 } } }, -- +1 -> +2 (Stone of Wieldance)
    [4256] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3226 } } }, -- +1 -> +2 (Stone of Voyage)

    -- Monk
    [4377] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3217 } } }, -- +1 -> +2 (Card of Ardor)
    [4357] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3220 } } }, -- +1 -> +2 (Jewel of Wieldance)
    [4257] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3227 } } }, -- +1 -> +2 (Coin of Voyage)

    -- White Mage
    [4378] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3217 } } }, -- +1 -> +2 (Card of Ardor)
    [4358] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3219 } } }, -- +1 -> +2 (Coin of Wieldance)
    [4258] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3228 } } }, -- +1 -> +2 (Jewel of Voyage)

    -- Black Mage
    [4379] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3216 } } }, -- +1 -> +2 (Jewel of Ardor)
    [4359] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3220 } } }, -- +1 -> +2 (Jewel of Wieldance)
    [4259] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3229 } } }, -- +1 -> +2 (Card of Voyage)

    -- Red Mage
    [4380] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3216 } } }, -- +1 -> +2 (Jewel of Ardor)
    [4360] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3218 } } }, -- +1 -> +2 (Stone of Wieldance)
    [4260] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3226 } } }, -- +1 -> +2 (Stone of Voyage)

    -- Thief
    [4381] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3215 } } }, -- +1 -> +2 (Coin of Ardor)
    [4361] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3218 } } }, -- +1 -> +2 (Stone of Wieldance)
    [4261] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3228 } } }, -- +1 -> +2 (Jewel of Voyage)

    -- Paladin
    [4382] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3214 } } }, -- +1 -> +2 (Stone of Ardor)
    [4362] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3221 } } }, -- +1 -> +2 (Card of Wieldance)
    [4262] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3226 } } }, -- +1 -> +2 (Stone of Voyage)

    -- Dark Knight
    [4383] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3215 } } }, -- +1 -> +2 (Coin of Ardor)
    [4363] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3219 } } }, -- +1 -> +2 (Coin of Wieldance)
    [4263] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3227 } } }, -- +1 -> +2 (Coin of Voyage)

    -- Beastmaster
    [4384] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3217 } } }, -- +1 -> +2 (Card of Ardor)
    [4364] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3218 } } }, -- +1 -> +2 (Stone of Wieldance)
    [4264] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3229 } } }, -- +1 -> +2 (Card of Voyage)

    -- Bard
    [4385] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3214 } } }, -- +1 -> +2 (Stone of Ardor)
    [4365] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3220 } } }, -- +1 -> +2 (Jewel of Wieldance)
    [4265] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3228 } } }, -- +1 -> +2 (Jewel of Voyage)

    -- Ranger
    [4386] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3215 } } }, -- +1 -> +2 (Coin of Ardor)
    [4366] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3219 } } }, -- +1 -> +2 (Coin of Wieldance)
    [4266] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3229 } } }, -- +1 -> +2 (Card of Voyage)

    -- Samurai
    [4387] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3216 } } }, -- +1 -> +2 (Jewel of Ardor)
    [4367] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3220 } } }, -- +1 -> +2 (Jewel of Wieldance)
    [4267] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3228 } } }, -- +1 -> +2 (Jewel of Voyage)

    -- Ninja
    [4388] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3214 } } }, -- +1 -> +2 (Stone of Ardor)
    [4368] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3221 } } }, -- +1 -> +2 (Card of Wieldance)
    [4268] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3229 } } }, -- +1 -> +2 (Card of Voyage)

    -- Dragoon
    [4389] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3217 } } }, -- +1 -> +2 (Card of Ardor)
    [4369] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3221 } } }, -- +1 -> +2 (Card of Wieldance)
    [4269] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3229 } } }, -- +1 -> +2 (Card of Voyage)

    -- Summoner
    [4390] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3215 } } }, -- +1 -> +2 (Coin of Ardor)
    [4370] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3220 } } }, -- +1 -> +2 (Jewel of Wieldance)
    [4270] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3226 } } }, -- +1 -> +2 (Stone of Voyage)

    -- Blue Mage
    [4391] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3214 } } }, -- +1 -> +2 (Stone of Ardor)
    [4371] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3219 } } }, -- +1 -> +2 (Coin of Wieldance)
    [4271] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3227 } } }, -- +1 -> +2 (Coin of Voyage)

    -- Corsair
    [4392] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3215 } } }, -- +1 -> +2 (Coin of Ardor)
    [4372] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3221 } } }, -- +1 -> +2 (Card of Wieldance)
    [4272] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3227 } } }, -- +1 -> +2 (Coin of Voyage)

    -- Puppetmaster
    [4393] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3216 } } }, -- +1 -> +2 (Jewel of Ardor)
    [4373] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3221 } } }, -- +1 -> +2 (Card of Wieldance)
    [4273] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3228 } } }, -- +1 -> +2 (Jewel of Voyage)

    -- Dancer
    [4394] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3216 } } }, -- +1 -> +2 (Jewel of Ardor)
    [4374] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3219 } } }, -- +1 -> +2 (Coin of Wieldance)
    [4274] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3226 } } }, -- +1 -> +2 (Stone of Voyage)

    -- Scholar
    [4395] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3217 } } }, -- +1 -> +2 (Card of Ardor)
    [4375] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3218 } } }, -- +1 -> +2 (Stone of Wieldance)
    [4275] = { check = checks.checkTradeTrials, reqs = { itemId = set{ 3227 } } }, -- +1 -> +2 (Coin of Voyage)
}
