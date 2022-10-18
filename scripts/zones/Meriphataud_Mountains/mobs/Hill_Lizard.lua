-----------------------------------
-- Area: Meriphataud Mountains
--  Mob: Hill Lizard
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 37, 1, xi.regime.type.FIELDS)
    xi.regime.checkRegime(player, mob, 38, 2, xi.regime.type.FIELDS)
end

return entity
