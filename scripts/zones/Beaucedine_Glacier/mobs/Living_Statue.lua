-----------------------------------
-- Area: Beaucedine Glacier
--  Mob: Living Statue
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 47, 2, xi.regime.type.FIELDS)
    xi.regime.checkRegime(player, mob, 48, 2, xi.regime.type.FIELDS)
    xi.regime.checkRegime(player, mob, 49, 3, xi.regime.type.FIELDS)
end

return entity
