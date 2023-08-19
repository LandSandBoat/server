-----------------------------------
-- Area: Sea Serpent Grotto (176)
--  Mob: Devil Manta
-- Note: Place holder Charybdis
-----------------------------------
local ID = zones[xi.zone.SEA_SERPENT_GROTTO]
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 810, 2, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.CHARYBDIS_PH, 10, math.random(28800, 43200)) -- 8 - 12 hours
end

return entity
