-----------------------------------
-- Area: Upper Delkfutt's Tower
--  Mob: Phasma
-- Note: PH for Ixtab
-----------------------------------
local ID = zones[xi.zone.UPPER_DELKFUTTS_TOWER]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.IXTAB[1], 5, 3600) -- 1 hour
end

return entity
