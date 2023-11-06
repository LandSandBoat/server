-----------------------------------
-- Area: Arrapago Reef
--  Mob: Draugar Servant
-- Note: PH for Bloody Bones
-----------------------------------
local ID = zones[xi.zone.ARRAPAGO_REEF]
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.BLOODY_BONES_PH, 5, 75600) -- 21 hours
end

return entity
