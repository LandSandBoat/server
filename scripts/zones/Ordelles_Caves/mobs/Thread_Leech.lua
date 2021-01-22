-----------------------------------
-- Area: Ordelle's Caves
--  Mob: Thread Leech
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 655, 2, tpz.regime.type.GROUNDS)
end

return entity
