-----------------------------------
-- Area: Qufim Island
--  MOB: Ophiotaurus
-----------------------------------
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 5)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
