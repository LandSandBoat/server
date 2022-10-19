-----------------------------------
-- Area: Dangruf Wadi
--  Mob: Prim Pika
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 644, 1, xi.regime.type.GROUNDS)
end

return entity
