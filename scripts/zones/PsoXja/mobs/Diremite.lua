-----------------------------------
-- Area: Pso'Xja
--  Mob: Diremite
-----------------------------------
local ID = zones[xi.zone.PSOXJA]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.GYRE_CARLIN, 5, 1800) -- 30 minutes.
end

return entity
