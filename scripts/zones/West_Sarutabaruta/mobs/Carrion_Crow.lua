-----------------------------------
-- Area: West Sarutabaruta
--  Mob: Carrion Crow
-- Note: PH for Nunyenunc
-----------------------------------
local ID = zones[xi.zone.WEST_SARUTABARUTA]
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 28, 2, xi.regime.type.FIELDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.NUNYENUNC_PH, 10, 3600) -- 1 hour minimum
end

return entity
