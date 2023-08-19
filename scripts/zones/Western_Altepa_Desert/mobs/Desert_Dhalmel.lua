-----------------------------------
-- Area: Western Altepa Desert
--  Mob: Desert Dhalmel
-- Note: Place holder for Celphie
-----------------------------------
local ID = zones[xi.zone.WESTERN_ALTEPA_DESERT]
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 135, 1, xi.regime.type.FIELDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.CELPHIE_PH, 5, math.random(7200, 28800)) -- 2 to 8 hours
end

return entity
