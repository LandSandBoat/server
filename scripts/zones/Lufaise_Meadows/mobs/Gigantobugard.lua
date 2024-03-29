-----------------------------------
-- Area: Lufaise_Meadows
--  Mob: Gigantobugard
-- Note: PH for Megalobugard
-----------------------------------
local ID = zones[xi.zone.LUFAISE_MEADOWS]
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.MEGALOBUGARD_PH, 10, 3600) -- 1 hour
end

return entity
