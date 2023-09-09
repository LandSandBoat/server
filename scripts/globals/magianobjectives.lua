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
    [1826] = { check = checks.checkTrials, reqs = { killWithWs = true, wSkill = set{ xi.weaponskill.FINAL_HEAVEN }, mobSystem = set{ xi.eco.BEAST } } },    -- 75 DMG+6 -> 75 DMG+8
    [1827] = { check = checks.checkTrials, reqs = { killWithWs = true, wSkill = set{ xi.weaponskill.FINAL_HEAVEN }, mobSystem = set{ xi.eco.AMORPH } } },   -- 75 DMG+8 -> 80
    [2253] = { check = checks.checkTrials, reqs = { killWithWs = true, wSkill = set{ xi.weaponskill.FINAL_HEAVEN }, mobSystem = set{ xi.eco.ARCANA } } },   -- 80 -> 85
    [2664] = { check = checks.checkTrials, reqs = { mobid = set{ 17326088 } } }, -- 85 -> 90 (Mildaunegeux)
    [3097] = { check = checks.checkTrials, reqs = { mobid = set{ 17330199 } } }, -- 90 -> 95 (Animated Knuckles)

    -- Mandau
    [1818] = { check = checks.checkTrials, reqs = { killWithWs = true, wSkill = set{ xi.weaponskill.MERCY_STROKE }, mobSystem = set{ xi.eco.PLANTOID } } },  -- 75 DMG+2 -> 75 DMG+3
    [1819] = { check = checks.checkTrials, reqs = { killWithWs = true, wSkill = set{ xi.weaponskill.MERCY_STROKE }, mobSystem = set{ xi.eco.BIRD } } },      -- 75 DMG+3 -> 80
    [2249] = { check = checks.checkTrials, reqs = { killWithWs = true, wSkill = set{ xi.weaponskill.MERCY_STROKE }, mobSystem = set{ xi.eco.DRAGON } } },    -- 80 -> 85
    [2660] = { check = checks.checkTrials, reqs = { mobid = set{ 17326087 } } }, -- 85 -> 90 (Quiebitiel)
    [3093] = { check = checks.checkTrials, reqs = { mobid = set{ 17330200 } } }, -- 90 -> 95 (Animated Dagger)

    -- Excalibur
    [1832] = { check = checks.checkTrials, reqs = { killWithWs = true, wSkill = set{ xi.weaponskill.KNIGHTS_OF_ROUND }, mobSystem = set{ xi.eco.LIZARD } } },    -- 75 DMG+2 -> 75 DMG+3
    [1833] = { check = checks.checkTrials, reqs = { killWithWs = true, wSkill = set{ xi.weaponskill.KNIGHTS_OF_ROUND }, mobSystem = set{ xi.eco.DRAGON } } },    -- 75 DMG+3 -> 80
    [2256] = { check = checks.checkTrials, reqs = { killWithWs = true, wSkill = set{ xi.weaponskill.KNIGHTS_OF_ROUND }, mobSystem = set{ xi.eco.BIRD } } },      -- 80 -> 85
    [2667] = { check = checks.checkTrials, reqs = { mobid = set{ 17326086 } } }, -- 85 -> 90 (Goublefaupe)
    [3100] = { check = checks.checkTrials, reqs = { mobid = set{ 17330201 } } }, -- 90 -> 95 (Animated Longsword)

    -- Ragnarok
    [1840] = { check = checks.checkTrials, reqs = { killWithWs = true, wSkill = set{ xi.weaponskill.SCOURGE }, mobSystem = set{ xi.eco.AQUAN } } },     -- 75 DMG+9 -> 75 DMG+10
    [1841] = { check = checks.checkTrials, reqs = { killWithWs = true, wSkill = set{ xi.weaponskill.SCOURGE }, mobSystem = set{ xi.eco.UNDEAD } } },    -- 75 DMG+10 -> 80
    [2260] = { check = checks.checkTrials, reqs = { killWithWs = true, wSkill = set{ xi.weaponskill.SCOURGE }, mobSystem = set{ xi.eco.ARCANA } } },    -- 80 -> 85
    [2671] = { check = checks.checkTrials, reqs = { mobid = set{ 17326086 } } }, -- 85 -> 90 (Goublefaupe)
    [3104] = { check = checks.checkTrials, reqs = { mobid = set{ 17330202 } } }, -- 90 -> 95 (Animated Claymore)

    -- Guttler
    [1842] = { check = checks.checkTrials, reqs = { killWithWs = true, wSkill = set{ xi.weaponskill.ONSLAUGHT }, mobSystem = set{ xi.eco.BEAST } } },     -- 75 DMG+6 -> 75 DMG+7
    [1843] = { check = checks.checkTrials, reqs = { killWithWs = true, wSkill = set{ xi.weaponskill.ONSLAUGHT }, mobSystem = set{ xi.eco.AMORPH } } },    -- 75 DMG+7 -> 80
    [2261] = { check = checks.checkTrials, reqs = { killWithWs = true, wSkill = set{ xi.weaponskill.ONSLAUGHT }, mobSystem = set{ xi.eco.BIRD } } },      -- 80 -> 85
    [2672] = { check = checks.checkTrials, reqs = { mobid = set{ 17326090 } } }, -- 85 -> 90 (Dagourmarche)
    [3105] = { check = checks.checkTrials, reqs = { mobid = set{ 17330203 } } }, -- 90 -> 95 (Animated Tabar)

    -- Bravura
    [1846] = { check = checks.checkTrials, reqs = { killWithWs = true, wSkill = set{ xi.weaponskill.METATRON_TORMENT }, mobSystem = set{ xi.eco.UNDEAD } } },    -- 75 DMG+7 -> 75 DMG+9
    [1847] = { check = checks.checkTrials, reqs = { killWithWs = true, wSkill = set{ xi.weaponskill.METATRON_TORMENT }, mobSystem = set{ xi.eco.PLANTOID } } },  -- 75 DMG+9 -> 80
    [2263] = { check = checks.checkTrials, reqs = { killWithWs = true, wSkill = set{ xi.weaponskill.METATRON_TORMENT }, mobSystem = set{ xi.eco.DRAGON } } },    -- 80 -> 85
    [2674] = { check = checks.checkTrials, reqs = { mobid = set{ 17326086 } } }, -- 85 -> 90 (Goublefaupe)
    [3107] = { check = checks.checkTrials, reqs = { mobid = set{ 17330204 } } }, -- 90 -> 95 (Animated Great Axe)

    -- Gungnir
    [1850] = { check = checks.checkTrials, reqs = { killWithWs = true, wSkill = set{ xi.weaponskill.GEIRSKOGUL }, mobSystem = set{ xi.eco.ARCANA } } },   -- 75 DMG+7 -> 75 DMG+9
    [1851] = { check = checks.checkTrials, reqs = { killWithWs = true, wSkill = set{ xi.weaponskill.GEIRSKOGUL }, mobSystem = set{ xi.eco.VERMIN } } },   -- 75 DMG+9 -> 80
    [2267] = { check = checks.checkTrials, reqs = { killWithWs = true, wSkill = set{ xi.weaponskill.GEIRSKOGUL }, mobSystem = set{ xi.eco.AQUAN } } },    -- 80 -> 85
    [2678] = { check = checks.checkTrials, reqs = { mobid = set{ 17326090 } } }, -- 85 -> 90 (Dagourmarche)
    [3111] = { check = checks.checkTrials, reqs = { mobid = set{ 17330205 } } }, -- 90 -> 95 (Animated Spear)

    -- Apocalypse
    [1854] = { check = checks.checkTrials, reqs = { killWithWs = true, wSkill = set{ xi.weaponskill.CATASTROPHE }, mobSystem = set{ xi.eco.LIZARD } } },   -- 75 DMG+7 -> 75 DMG+9
    [1855] = { check = checks.checkTrials, reqs = { killWithWs = true, wSkill = set{ xi.weaponskill.CATASTROPHE }, mobSystem = set{ xi.eco.BIRD } } },     -- 75 DMG+9 -> 80
    [2265] = { check = checks.checkTrials, reqs = { killWithWs = true, wSkill = set{ xi.weaponskill.CATASTROPHE }, mobSystem = set{ xi.eco.BEAST } } },    -- 80 -> 85
    [2676] = { check = checks.checkTrials, reqs = { mobid = set{ 17326089 } } }, -- 85 -> 90 (Velosareon)
    [3109] = { check = checks.checkTrials, reqs = { mobid = set{ 17330206 } } }, -- 90 -> 95 (Animated Scythe)

    -- Kikoku
    [1858] = { check = checks.checkTrials, reqs = { killWithWs = true, wSkill = set{ xi.weaponskill.BLADE_METSU }, mobSystem = set{ xi.eco.AMORPH } } },   -- 75 DMG+3 -> 75 DMG+4
    [1859] = { check = checks.checkTrials, reqs = { killWithWs = true, wSkill = set{ xi.weaponskill.BLADE_METSU }, mobSystem = set{ xi.eco.AQUAN } } },    -- 75 DMG+4 -> 80
    [2269] = { check = checks.checkTrials, reqs = { killWithWs = true, wSkill = set{ xi.weaponskill.BLADE_METSU }, mobSystem = set{ xi.eco.UNDEAD } } },   -- 80 -> 85
    [2680] = { check = checks.checkTrials, reqs = { mobid = set{ 17326088 } } }, -- 85 -> 90 (Mildaunegeux)
    [3113] = { check = checks.checkTrials, reqs = { mobid = set{ 17330207 } } }, -- 90 -> 95 (Animated Kunai)

    -- Amanomurakumo
    [1862] = { check = checks.checkTrials, reqs = { killWithWs = true, wSkill = set{ xi.weaponskill.TACHI_KAITEN }, mobSystem = set{ xi.eco.ARCANA } } },    -- 75 DMG+5 -> 75 DMG+6
    [1863] = { check = checks.checkTrials, reqs = { killWithWs = true, wSkill = set{ xi.weaponskill.TACHI_KAITEN }, mobSystem = set{ xi.eco.BIRD } } },      -- 75 DMG+6 -> 80
    [2271] = { check = checks.checkTrials, reqs = { killWithWs = true, wSkill = set{ xi.weaponskill.TACHI_KAITEN }, mobSystem = set{ xi.eco.AQUAN } } },     -- 80 -> 85
    [2682] = { check = checks.checkTrials, reqs = { mobid = set{ 17326089 } } }, -- 85 -> 90 (Velosareon)
    [3115] = { check = checks.checkTrials, reqs = { mobid = set{ 17330208 } } }, -- 90 -> 95 (Animated Tachi)

    -- Mjollnir
    [1866] = { check = checks.checkTrials, reqs = { killWithWs = true, wSkill = set{ xi.weaponskill.RANDGRITH }, mobSystem = set{ xi.eco.AMORPH } } },    -- 75 DMG+8 -> 75 DMG+9
    [1867] = { check = checks.checkTrials, reqs = { killWithWs = true, wSkill = set{ xi.weaponskill.RANDGRITH }, mobSystem = set{ xi.eco.VERMIN } } },    -- 75 DMG+9 -> 80
    [2273] = { check = checks.checkTrials, reqs = { killWithWs = true, wSkill = set{ xi.weaponskill.RANDGRITH }, mobSystem = set{ xi.eco.BIRD } } },      -- 80 -> 85
    [2684] = { check = checks.checkTrials, reqs = { mobid = set{ 17326087 } } }, -- 85 -> 90 (Quiebitiel)
    [3117] = { check = checks.checkTrials, reqs = { mobid = set{ 17330209 } } }, -- 90 -> 95 (Animated Tachi)

    -- Claustrum
    [1870] = { check = checks.checkTrials, reqs = { killWithWs = true, wSkill = set{ xi.weaponskill.GATE_OF_TARTARUS }, mobSystem = set{ xi.eco.UNDEAD } } },   -- 75 DMG+10 -> 75 DMG+12
    [1871] = { check = checks.checkTrials, reqs = { killWithWs = true, wSkill = set{ xi.weaponskill.GATE_OF_TARTARUS }, mobSystem = set{ xi.eco.BEAST } } },    -- 75 DMG+12 -> 80
    [2275] = { check = checks.checkTrials, reqs = { killWithWs = true, wSkill = set{ xi.weaponskill.GATE_OF_TARTARUS }, mobSystem = set{ xi.eco.PLANTOID } } }, -- 80 -> 85
    [2686] = { check = checks.checkTrials, reqs = { mobid = set{ 17326090 } } }, -- 85 -> 90 (Dagourmarche)
    [3119] = { check = checks.checkTrials, reqs = { mobid = set{ 17330210 } } }, -- 90 -> 95 (Animated Staff)

    -- Annihilator
    [1081] = { check = checks.checkTrials, reqs = { killWithWs = false, wSkill = set{ xi.weaponskill.CORONACH }, mobSystem = set{ xi.eco.BEAST } } },    -- 75 -> 75 DMG+2
    [1082] = { check = checks.checkTrials, reqs = { killWithWs = true, wSkill = set{ xi.weaponskill.CORONACH }, mobSystem = set{ xi.eco.AQUAN } } },     -- 75 DMG+2 -> 75 DMG+6
    [1878] = { check = checks.checkTrials, reqs = { killWithWs = true, wSkill = set{ xi.weaponskill.CORONACH }, mobSystem = set{ xi.eco.ARCANA } } },    -- 75 DMG+6 -> 75 DMG+8
    [1879] = { check = checks.checkTrials, reqs = { killWithWs = true, wSkill = set{ xi.weaponskill.CORONACH }, mobSystem = set{ xi.eco.PLANTOID } } },  -- 75 DMG+8 -> 80
    [2280] = { check = checks.checkTrials, reqs = { killWithWs = true, wSkill = set{ xi.weaponskill.CORONACH }, mobSystem = set{ xi.eco.UNDEAD } } },    -- 80 -> 85
    [2691] = { check = checks.checkTrials, reqs = { mobid = set{ 17326088 } } }, -- 85 -> 90 (Mildaunegeux)
    [3124] = { check = checks.checkTrials, reqs = { mobid = set{ 17330212 } } }, -- 90 -> 95 (Animated Gun)

    -- Yoichinoyumi
    [1090] = { check = checks.checkTrials, reqs = { killWithWs = false, wSkill = set{ xi.weaponskill.NAMAS_ARROW }, mobSystem = set{ xi.eco.AMORPH } } },   -- 75 -> 75 DMG+2
    [1091] = { check = checks.checkTrials, reqs = { killWithWs = true, wSkill = set{ xi.weaponskill.NAMAS_ARROW }, mobSystem = set{ xi.eco.BEAST } } },     -- 75 DMG+2 -> 75 DMG+5
    [1884] = { check = checks.checkTrials, reqs = { killWithWs = true, wSkill = set{ xi.weaponskill.NAMAS_ARROW }, mobSystem = set{ xi.eco.LIZARD } } },    -- 75 DMG+5 -> 75 DMG+8
    [1885] = { check = checks.checkTrials, reqs = { killWithWs = true, wSkill = set{ xi.weaponskill.NAMAS_ARROW }, mobSystem = set{ xi.eco.AQUAN } } },     -- 75 DMG+8 -> 80
    [2279] = { check = checks.checkTrials, reqs = { killWithWs = true, wSkill = set{ xi.weaponskill.NAMAS_ARROW }, mobSystem = set{ xi.eco.VERMIN } } },    -- 80 -> 85
    [2690] = { check = checks.checkTrials, reqs = { mobid = set{ 17326089 } } }, -- 85 -> 90 (Velosareon)
    [3123] = { check = checks.checkTrials, reqs = { mobid = set{ 17330211 } } }, -- 90 -> 95 (Animated Longbow)

    -- Gjallarhorn
    [2713] = { check = checks.checkTrials, reqs = { mobid = set{ 17547265 } } }, -- 75 -> 80 (Goblin Golem)
    [2714] = { check = checks.checkTrials, reqs = { mobid = set{ 17543169 } } }, -- 80 -> 85 (Tzee Xicu Idol)
    [2715] = { check = checks.checkTrials, reqs = { mobid = set{ 17326087 } } }, -- 85 -> 90 (Quiebitiel)
    [3128] = { check = checks.checkTrials, reqs = { mobid = set{ 17330213 } } }, -- 90 -> 95 (Animated Horn)

    -- Aegis
    [4401] = { check = checks.checkTrials, reqs = { mobid = set{ 17539073 } } }, -- 75 -> 80 (Gu'Dha Effigy)
    [4402] = { check = checks.checkTrials, reqs = { mobid = set{ 17534977 } } }, -- 80 -> 85 (Overlord's Tombstone)
    [4403] = { check = checks.checkTrials, reqs = { mobid = set{ 17326086 } } }, -- 85 -> 90 (Goublefaupe)
    [4448] = { check = checks.checkTrials, reqs = { mobid = set{ 17330214 } } }, -- 90 -> 95 (Animated Shield)
}
