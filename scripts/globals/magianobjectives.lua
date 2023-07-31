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
