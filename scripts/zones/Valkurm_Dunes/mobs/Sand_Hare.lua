-----------------------------------
-- Area: Valkurm Dunes
--  Mob: Sand Hare
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 7, 2, tpz.regime.type.FIELDS)
end

return entity
