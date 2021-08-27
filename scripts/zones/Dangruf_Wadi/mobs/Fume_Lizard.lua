-----------------------------------
-- Area: Dangruf Wadi
--  Mob: Fume Lizard
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    xi.regime.checkRegime(player, mob, 642, 1, xi.regime.type.GROUNDS)
end

return entity
