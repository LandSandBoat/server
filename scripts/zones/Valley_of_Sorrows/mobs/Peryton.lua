-----------------------------------
-- Area: Valley of Sorrows
--  Mob: Peryton
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 139, 2, xi.regime.type.FIELDS)
    xi.regime.checkRegime(player, mob, 141, 1, xi.regime.type.FIELDS)
end

return entity
