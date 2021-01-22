-----------------------------------
-- Area: Bostaunieux Oubliette
--  Mob: Dabilla
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 612, 1, tpz.regime.type.GROUNDS)
    tpz.regime.checkRegime(player, mob, 614, 1, tpz.regime.type.GROUNDS)
end

return entity
