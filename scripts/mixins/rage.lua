--[[
Mobs that enter rage mode after a specified amount of time in combat. Controlled by following vars that can be set onMobSpawn:

localVar    default     description
--------    -------     -----------
rageTimer   1200        seconds into combat at which point the mob will rage.

https://ffxiclopedia.fandom.com/wiki/Rage
--]]

require("scripts/globals/mixins")

g_mixins = g_mixins or {}

local lastCombatHPP = 0

local rageBuffs =
{
    {xi.mod.ATT, 9},
    {xi.mod.RATT, 9},
    {xi.mod.ACC, 9},
    {xi.mod.RACC, 9},
    {xi.mod.MATT, 9},
    {xi.mod.MDEF, 9},
    {xi.mod.MACC, 9},
    {xi.mod.MEVA, 9},
    {xi.mod.WSACC, 9},
    {xi.mod.EVA, 9},
    {xi.mod.RDEF, 9},
    {xi.mod.REVA, 9},
}

g_mixins.rage = function(rageMob)
    rageMob:addListener("SPAWN", "RAGE_SPAWN", function(mob)
        mob:setLocalVar("[rage]timer", 1200) -- 20 minutes
    end)

    rageMob:addListener("ENGAGE", "RAGE_ENGAGE", function(mob)
        if mob:getLocalVar("[rage]started") == 0 and mob:getLocalVar("[rage]at") == 0 then
            mob:setLocalVar("[rage]at", os.time() + mob:getLocalVar("[rage]timer"))
        end
        
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

            -- TODO: ATT, DEF, MACC, MATT, EVA, attack speed all increase
            -- boost mods - credit ASB (not sure who specifically)
            -- This is done seperately because getStat in lua_baseentity.cpp does not have cases for most of these
            for _, buff in pairs(rageBuffs) do
                local amt = math.ceil(mob:getMainLvl() * buff[2])
                mob:setLocalVar("[rage]mod_" .. buff[1], amt)
                mob:addMod(buff[1], amt)
            end
        end
    end)

    -- Todo: should happen when mob begins to regen while unclaimed. If 1st healing tick hasn't happened, retail mob is stil raged. 
    -- Test mob: Fafnir (dragon's aery, honey wine)
    rageMob:addListener("DISENGAGE", "RAGE_DISENGAGE", function(mob)
        -- the following is for checking for first tick healed instead of 100% health
        lastCombatHPP = mob:getHPP()
    end)
    
    -- implement check for if mob has healed (in this case to 100%) and drop rage if so
    rageMob:addListener("ROAM_TICK", "RAGE_RTICK", function(mob)
        --change mob:getHPP() == 100 to mob:getHPP() > lastCombatHPP to check for first healing tick instead of full health
        if mob:getHPP() == 100 then
            if mob:getLocalVar("[rage]at") > 0 then
                mob:setLocalVar("[rage]at", 0)
            end
            
            if mob:getLocalVar("[rage]started") == 1 then
                mob:setLocalVar("[rage]started", 0)
            end
            
            -- unboost stats
            for i = xi.mod.STR, xi.mod.CHR do
                local amt = mob:getLocalVar("[rage]mod_" .. i)
                mob:setLocalVar("[rage]mod_" .. i, 0) --credit ASB, this fixes the stats being zeroed out completely when rage is dropped
                mob:delMod(i, amt)
            end

            -- TODO: ATT, DEF, MACC, MATT, EVA, attack speed all decrease
            -- delete mods - credit ASB (not sure who specifically)
            -- This is done seperately because getStat in lua_baseentity.cpp does not have cases for most of these
            for _, buff in pairs(rageBuffs) do
                local amt = mob:getLocalVar("[rage]mod_" .. buff[1])
                mob:setLocalVar("[rage]mod_" .. buff[1], 0)
                mob:delMod(buff[1], amt)
            end
        end
        
    end)
end

return g_mixins.rage
