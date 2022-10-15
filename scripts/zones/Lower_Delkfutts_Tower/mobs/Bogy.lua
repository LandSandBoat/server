-----------------------------------
-- Area: Lower Delkfutt's Tower
--  Mob: Bogy
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 780, 2, xi.regime.type.GROUNDS)
end

return entity
