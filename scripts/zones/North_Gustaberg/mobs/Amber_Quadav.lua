-----------------------------------
-- Area: North Gustaberg
--  Mob: Amber Quadav
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 19, 1, xi.regime.type.FIELDS)
    xi.regime.checkRegime(player, mob, 59, 1, xi.regime.type.FIELDS)
end

return entity
