-----------------------------------
-- Area: Bostaunieux Oubliette
--  Mob: Wurdalak
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 617, 1, tpz.regime.type.GROUNDS)
end

return entity
