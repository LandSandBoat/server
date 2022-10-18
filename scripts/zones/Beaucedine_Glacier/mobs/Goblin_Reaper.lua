-----------------------------------
-- Area: Beaucedine Glacier
--  Mob: Goblin Reaper
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 46, 2, xi.regime.type.FIELDS)
    xi.regime.checkRegime(player, mob, 49, 1, xi.regime.type.FIELDS)
    xi.regime.checkRegime(player, mob, 50, 2, xi.regime.type.FIELDS)
end

return entity
