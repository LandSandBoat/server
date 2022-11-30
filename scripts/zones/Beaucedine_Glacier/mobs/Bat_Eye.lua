-----------------------------------
-- Area: Beaucedine Glacier
--  Mob: Bat Eye
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 48, 1, xi.regime.type.FIELDS)
    xi.regime.checkRegime(player, mob, 49, 2, xi.regime.type.FIELDS)
    xi.regime.checkRegime(player, mob, 50, 3, xi.regime.type.FIELDS)
end

return entity
