-----------------------------------
-- Area: Labyrinth of Onzozo
--  Mob: Torama
-- Note: Place holder Ose
-----------------------------------
local ID = zones[xi.zone.LABYRINTH_OF_ONZOZO]
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 775, 1, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.OSE_PH, 5, 3600) -- 1 hour
end

return entity
