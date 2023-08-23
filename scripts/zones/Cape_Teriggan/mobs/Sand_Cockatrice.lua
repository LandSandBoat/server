-----------------------------------
-- Area: Cape Teriggan
--  Mob: Sand Cockatrice
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 107, 2, xi.regime.type.FIELDS)
    xi.regime.checkRegime(player, mob, 108, 1, xi.regime.type.FIELDS)
end

return entity
