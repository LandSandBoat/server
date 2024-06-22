-----------------------------------
-- Area: Jugner_Forest
-- NM: Skeleton Esquire
-- Quest: A Timely Visit
-----------------------------------
local entity = {}
entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.CHECK_AS_NM, 1)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)
end

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
end

return entity
