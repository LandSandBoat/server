-----------------------------------
-- Area: Garlaige Citadel
--  Mob: Wingrats
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 703, 1, tpz.regime.type.GROUNDS)
end

return entity
