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
        {{xi.mod.REGEN}, 1000, 0, "scolopendra_killed"},
        {{xi.mod.CRITHITRATE}, 100, 10, "stringes_killed"},
        {{xi.mod.UDMGPHYS, xi.mod.UDMGRANGE, xi.mod.UDMGMAGIC, xi.mod.UDMGBREATH}, -99, 0, "stringes_killed"},
        {{xi.mod.FIRERES}, 1000, 0, "fire_killed"},
        {{xi.mod.ICERES}, 1000, 0, "ice_killed"},
        {{xi.mod.WINDRES}, 1000, 0, "air_killed"},
        {{xi.mod.EARTHRES}, 1000, 0, "earth_killed"},
        {{xi.mod.THUNDERRES}, 1000, 0, "thunder_killed"},
        {{xi.mod.WATERRES}, 1000, 0, "water_killed"},
        {{xi.mod.LIGHTRES}, 1000, 0, "light_killed"},
        {{xi.mod.DARKRES}, 1000, 0, "dark_killed"},
    }
    for _, buffTable in pairs(xi.dynamis.buffsAntaeus) do
        if buffTable[1][1] ~= nil then
            mob:setMod(buffTable[1][1], buffTable[2])
        end
        if buffTable[1][2] ~= nil then
            mob:setMod(buffTable[1][2], buffTable[2])
        end
        if buffTable[1][3] ~= nil then
            mob:setMod(buffTable[1][3], buffTable[2])
        end
        if buffTable[1][4] ~= nil then
            mob:setMod(buffTable[1][4], buffTable[2])
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
    for _, buffTable in pairs(xi.dynamis.buffsAntaeus) do
        if zone:getLocalVar(buffTable[4]) == 1 then
            if buffTable[1][1] ~= nil then
                mob:setMod(buffTable[1][1], buffTable[3])
            end
            if buffTable[1][2] ~= nil then
                mob:setMod(buffTable[1][2], buffTable[3])
            end
            if buffTable[1][3] ~= nil then
                mob:setMod(buffTable[1][3], buffTable[3])
            end
            if buffTable[1][4] ~= nil then
                mob:setMod(buffTable[1][4], buffTable[3])
            end
            table.remove(xi.dynamis.buffsAntaeus, var)
        end
    end
end
