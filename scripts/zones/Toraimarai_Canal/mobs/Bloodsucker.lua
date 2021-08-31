-----------------------------------
-- Area: Toraimarai Canal
--  Mob: Bloodsucker
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    xi.regime.checkRegime(player, mob, 620, 2, xi.regime.type.GROUNDS)
end

return entity
