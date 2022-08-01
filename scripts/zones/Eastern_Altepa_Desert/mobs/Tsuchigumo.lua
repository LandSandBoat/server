-----------------------------------
-- Area: Eastern Altepa Desert
--  Mob: Tsuchigumo
-- Involved in Quest: 20 in Pirate Years
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 300) -- 3 minutes
end

entity.onMobSpawn = function(mob)
    mob:setLocalVar("despawnTime", os.time() + 300)
    mob:setMobMod(xi.mobMod.NO_LINK, 1)
end

entity.onMobRoam = function(mob)
    -- wont link for 5 seconds after spawn, giving a chance to pull with sneak
    mob:timer(5000, function(mobArg)
        mobArg:setMobMod(xi.mobMod.NO_LINK, 0)
        end)
    -- if not claimed within 5 minutes of spawning, despawn
    local despawnTime = mob:getLocalVar("despawnTime")
    if despawnTime > 0 and os.time() > despawnTime then
        DespawnMob(mob:getID())
    end
end

entity.onMobDeath = function(mob, player, isKiller)
    if player:getCharVar("twentyInPirateYearsCS") == 3 then
        player:incrementCharVar("TsuchigumoKilled", 1)
    end
end

return entity
