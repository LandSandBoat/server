-----------------------------------
-- Antaeus Era Module
-----------------------------------
require("scripts/globals/dynamis")
require("scripts/globals/zone")
-----------------------------------

xi = xi or {}
xi.dynamis = xi.dynamis or {}

xi.dynamis.onSpawnAntaeus = function(mob)
    mob:setRoamFlags(xi.roamFlag.EVENT)
    xi.dynamis.setMegaBossStats(mob)
    -- Set Removable Mods
    xi.dynamis.buffsAntaeus = 
    {
        ["Scolopendra"] = {{xi.mod.REGEN}, 1000, 0},
        ["Stringes"] = {{xi.mod.CRITHITRATE}, 100, 10},
        ["Suttung"] = {{xi.mod.UDMGPHYS, xi.mod.UDMGRANGE, xi.mod.UDMGMAGIC, xi.mod.UDMGBREATH}, -99, 0},
        ["Fire_Elemental"] = {{xi.mod.FIRERES}, 1000, 0},
        ["Ice_Elemental"] = {{xi.mod.ICERES}, 1000, 0},
        ["Air_Elemental"] = {{xi.mod.WINDRES}, 1000, 0},
        ["Earth_Elemental"] = {{xi.mod.EARTHRES}, 1000, 0},
        ["Thunder_Elemental"] = {{xi.mod.THUNDERRES}, 1000, 0},
        ["Water_Elemental"] = {{xi.mod.WATERRES}, 1000, 0},
        ["Light_Elemental"] = {{xi.mod.LIGHTRES}, 1000, 0},
        ["Dark_Elemental"] = {{xi.mod.DARKRES}, 1000, 0},
    }
    for var, buffTable in pairs(xi.dynamis.buffsAntaeus) do
        for _, buff in pairs(buffTable[1]) do
            mob:setMod(buff, buffTable[2])
        end
    end
    -- Set Non-Removable Mods
    -- Anateus should not standback and should be able to avoid most RAs via melee range. (https://ffxiclopedia.fandom.com/wiki/Antaeus)
    mob:addMobMod(xi.mobMod.NO_STANDBACK, 1)
    -- Sleep Res and Lullaby Res are unverified but added in case (https://ffxiclopedia.fandom.com/wiki/Antaeus)
    mob:addMod(xi.mod.SLEEPRES, 99)
    mob:addMod(xi.mod.LULLABYRES, 99)
    -- Adding Normal Dynamis Boss Resistances and Regain
    mob:addMod(xi.mod.GRAVITYRES, 40)
    mob:addMod(xi.mod.BINDRES, 40)
    mob:addMod(xi.mod.REGAIN, 50)
end

xi.dynamis.onEngagedAntaeus = function(mob, target)
    xi.dynamis.parentOnEngaged(mob, target)
end

xi.dynamis.onFightAntaeus = function(mob, target)
    local zone = mob:getZone()

    for var, buffTable in pairs(xi.dynamis.buffsAntaeus) do
        if not GetMobByID(zone:getLocalVar(var)):isAlive() then
            for _, buff in pairs(buffTable[1]) do
                mob:setMod(buff, buffTable[3])
            end
            table.remove(xi.dynamis.buffsAntaeus, var)
        end
    end
end
