-----------------------------------
-- Area: Bostaunieux Oubliette
--  Mob: Panna Cotta
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 614, 2, tpz.regime.type.GROUNDS)
    tpz.regime.checkRegime(player, mob, 615, 2, tpz.regime.type.GROUNDS)
end

return entity
