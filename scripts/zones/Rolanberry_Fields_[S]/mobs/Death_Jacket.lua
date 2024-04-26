-----------------------------------
-- Area: Rolanberry Fields [S]
--  Mob: Death Jacket
-- Note: PH for Erle
-----------------------------------
local ID = zones[xi.zone.ROLANBERRY_FIELDS_S]
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.ERLE_PH, 10, 5400) -- 1.5 hour
end

return entity
