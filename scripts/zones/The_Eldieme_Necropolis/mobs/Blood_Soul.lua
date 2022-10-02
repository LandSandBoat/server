-----------------------------------
-- Area: The Eldieme Necropolis
--  Mob: Blood Soul
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 674, 2, xi.regime.type.GROUNDS)
end

return entity
