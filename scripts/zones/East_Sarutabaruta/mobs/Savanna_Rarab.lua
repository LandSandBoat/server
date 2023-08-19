-----------------------------------
-- Area: East Sarutabaruta
--  Mob: Savanna Rarab
-- Note: PH for Sharp Eared Ropipi
-----------------------------------
local ID = zones[xi.zone.EAST_SARUTABARUTA]
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 91, 1, xi.regime.type.FIELDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.SHARP_EARED_ROPIPI_PH, 20, 300) -- 5 minutes
end

return entity
