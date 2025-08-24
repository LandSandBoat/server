-----------------------------------
-- Area: Riverne - Site A01
--  Mob: Flamedrake PH
-----------------------------------
local ID = zones[xi.zone.RIVERNE_SITE_A01]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.AIATAR, 10, 75600) -- 50 minutes
end

return entity
