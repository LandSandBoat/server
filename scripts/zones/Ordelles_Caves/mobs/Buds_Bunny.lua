-----------------------------------
-- Area: Ordelle's Caves
--  Mob: Buds Bunny
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 661, 1, tpz.regime.type.GROUNDS)
end

return entity
