--[[
Mobs that enter rage mode after a specified amount of time in combat. Controlled by following vars that can be set onMobSpawn:

localVar    default     description
--------    -------     -----------
rageTimer   1200        seconds into combat at which point the mob will rage.

https://ffxiclopedia.fandom.com/wiki/Rage
--]]

require("scripts/globals/mixins")

g_mixins = g_mixins or {}

local rageBuffs =
{
    { xi.mod.ATT, 9 },
    { xi.mod.RATT, 9 },
    { xi.mod.ACC, 9 },
    { xi.mod.RACC, 9 },
    { xi.mod.MATT, 9 },
    { xi.mod.MDEF, 9 },
    { xi.mod.MACC, 9 },
    { xi.mod.MEVA, 9 },
    { xi.mod.WSACC, 9 },
    { xi.mod.EVA, 9 },
    { xi.mod.RDEF, 9 },
    { xi.mod.REVA, 9 },
}

g_mixins.rage = function(rageMob)
    rageMob:addListener("SPAWN", "RAGE_SPAWN", function(mob)
        mob:setLocalVar("[rage]timer", 1200) -- 20 minutes
    end)

    rageMob:addListener("ENGAGE", "RAGE_ENGAGE", function(mob)
        mob:setLocalVar("[rage]at", os.time() + mob:getLocalVar("[rage]timer"))
    end)

    rageMob:addListener("COMBAT_TICK", "RAGE_CTICK", function(mob)
        if
            mob:getLocalVar("[rage]started") == 0 and
            os.time() > mob:getLocalVar("[rage]at")
        then
            mob:setLocalVar("[rage]started", 1)

            -- boost stats
            for i = xi.mod.STR, xi.mod.CHR do
                local amt = math.ceil(mob:getStat(i) * 9)
                mob:setLocalVar("[rage]mod_" .. i, amt)
                mob:addMod(i, amt)
            end

            -- boost mods
            for _, buff in pairs(rageBuffs) do
                local amt = math.ceil(mob:getMainLvl() * buff[2])
                mob:setLocalVar("[rage]mod_" .. buff[1], amt)
                mob:addMod(buff[1], amt)
            end
        end
    end)

    rageMob:addListener("ROAM_TICK", "RAGE_ROAM_TICK", function(mob)
        if mob:getLocalVar("[rage]started") == 1 and mob:getHPP() == 100 then
            mob:setLocalVar("[rage]started", 0)
            -- unboost stats
            for i = xi.mod.STR, xi.mod.CHR do
                local amt = mob:getLocalVar("[rage]mod_" .. i)
                mob:setLocalVar("[rage]mod_" .. i, 0)
                mob:delMod(i, amt)
            end

            -- unboost mods
            for _, buff in pairs(rageBuffs) do
                local amt = mob:getLocalVar("[rage]mod_" .. buff[1])
                mob:setLocalVar("[rage]mod_" .. buff[1], 0)
                mob:delMod(buff[1], amt)
            end
        end
    end)
end

return g_mixins.rage
