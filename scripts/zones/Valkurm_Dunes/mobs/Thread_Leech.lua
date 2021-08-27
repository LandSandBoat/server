-----------------------------------
-- Area: Valkurm Dunes
--  Mob: Thread Leech
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    xi.regime.checkRegime(player, mob, 57, 1, xi.regime.type.FIELDS)
end

return entity
