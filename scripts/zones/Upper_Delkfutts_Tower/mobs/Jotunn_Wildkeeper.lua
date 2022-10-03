-----------------------------------
-- Area: Upper Delkfutt's Tower
--  Mob: Jotunn Wildkeeper
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 787, 2, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 789, 1, xi.regime.type.GROUNDS)
end

return entity
