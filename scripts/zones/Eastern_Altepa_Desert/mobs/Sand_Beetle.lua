-----------------------------------
-- Area: Eastern Altepa Desert
--  Mob: Sand Beetle
-- Note: PH for Donnergugi
-----------------------------------
local ID = zones[xi.zone.EASTERN_ALTEPA_DESERT]
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 110, 3, xi.regime.type.FIELDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.DONNERGUGI_PH, 10, 3600) -- 1 hour
end

return entity
