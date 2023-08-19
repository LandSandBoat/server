-----------------------------------
-- Area: Pashhow Marshlands
--  Mob: Marsh Funguar
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 24, 1, xi.regime.type.FIELDS)
    xi.regime.checkRegime(player, mob, 60, 2, xi.regime.type.FIELDS)
end

return entity
