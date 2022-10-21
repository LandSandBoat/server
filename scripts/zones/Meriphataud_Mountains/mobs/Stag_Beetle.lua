-----------------------------------
-- Area: Meriphataud Mountains
--  Mob: Stag Beetle
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 38, 1, xi.regime.type.FIELDS)
    xi.regime.checkRegime(player, mob, 39, 2, xi.regime.type.FIELDS)
end

return entity
