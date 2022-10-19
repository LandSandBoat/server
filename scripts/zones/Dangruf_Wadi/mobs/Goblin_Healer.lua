-----------------------------------
-- Area: Dangruf Wadi
--  Mob: Goblin Healer
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 640, 1, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 644, 2, xi.regime.type.GROUNDS)
end

return entity
