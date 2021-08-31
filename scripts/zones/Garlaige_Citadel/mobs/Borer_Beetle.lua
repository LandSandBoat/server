-----------------------------------
-- Area: Garlaige Citadel
--  Mob: Borer Beetle
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    xi.regime.checkRegime(player, mob, 704, 2, xi.regime.type.GROUNDS)
end

return entity
