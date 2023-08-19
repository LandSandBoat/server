-----------------------------------
-- Area: Qufim Island
--  MOB: Ophiotaurus
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 5)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
