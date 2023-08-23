-----------------------------------
-- Area: North Gustaberg [S]
--  Mob: Huge Spider
-- Note: Place holder for Ankabut
-----------------------------------
local ID = zones[xi.zone.NORTH_GUSTABERG_S]
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.ANKABUT_PH, 10, 3600) -- 1 hour
end

return entity
