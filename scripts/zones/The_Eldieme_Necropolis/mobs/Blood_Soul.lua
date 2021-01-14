-----------------------------------
-- Area: The Eldieme Necropolis
--  Mob: Blood Soul
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 674, 2, tpz.regime.type.GROUNDS)
end

return entity
