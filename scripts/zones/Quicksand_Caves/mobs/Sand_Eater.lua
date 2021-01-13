-----------------------------------
-- Area: Quicksand Caves
--  Mob: Sand Eater
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 814, 1, tpz.regime.type.GROUNDS)
end

return entity
