-----------------------------------
-- Area: Ordelle's Caves
--  Mob: Thread Leech
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    xi.regime.checkRegime(player, mob, 655, 2, xi.regime.type.GROUNDS)
end

return entity
