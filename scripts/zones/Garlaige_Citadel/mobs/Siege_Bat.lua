-----------------------------------
-- Area: Garlaige Citadel
--  Mob: Siege Bat
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    xi.regime.checkRegime(player, mob, 704, 1, xi.regime.type.GROUNDS)
end

return entity
