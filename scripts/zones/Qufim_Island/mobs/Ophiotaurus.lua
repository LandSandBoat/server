-----------------------------------
-- Area: Qufim Island
--  MOB: Ophiotaurus
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 5)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
