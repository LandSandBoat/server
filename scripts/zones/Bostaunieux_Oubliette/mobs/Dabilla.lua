-----------------------------------
-- Area: Bostaunieux Oubliette
--  Mob: Dabilla
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    xi.regime.checkRegime(player, mob, 612, 1, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 614, 1, xi.regime.type.GROUNDS)
end

return entity
