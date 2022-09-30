-----------------------------------
-- Area: Buburimu Peninsula
--  Mob: Sylvestre
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 32, 1, xi.regime.type.FIELDS)
    xi.regime.checkRegime(player, mob, 33, 2, xi.regime.type.FIELDS)
end

return entity
