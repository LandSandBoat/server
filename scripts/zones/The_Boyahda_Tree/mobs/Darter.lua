-----------------------------------
-- Area: The Boyahda Tree
--  Mob: Darter
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 724, 2, tpz.regime.type.GROUNDS)
end

return entity
