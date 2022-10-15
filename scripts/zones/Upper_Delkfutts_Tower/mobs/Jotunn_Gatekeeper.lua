-----------------------------------
-- Area: Upper Delkfutt's Tower
--  Mob: Jotunn Gatekeeper
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 786, 2, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 788, 1, xi.regime.type.GROUNDS)
end

return entity
