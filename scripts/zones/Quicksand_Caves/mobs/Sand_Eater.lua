-----------------------------------
-- Area: Quicksand Caves
--  Mob: Sand Eater
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    xi.regime.checkRegime(player, mob, 814, 1, xi.regime.type.GROUNDS)
end

return entity
