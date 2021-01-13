-----------------------------------
-- Area: Valkurm Dunes
--  Mob: Hill Lizard
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 7, 1, tpz.regime.type.FIELDS)
    tpz.regime.checkRegime(player, mob, 8, 2, tpz.regime.type.FIELDS)
end

return entity
