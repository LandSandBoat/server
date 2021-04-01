-----------------------------------
-- Area: Toraimarai Canal
--  Mob: Starborer
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    xi.regime.checkRegime(player, mob, 622, 1, xi.regime.type.GROUNDS)
end

return entity
