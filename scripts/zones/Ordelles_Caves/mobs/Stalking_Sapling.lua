-----------------------------------
-- Area: Ordelle's Caves
--  Mob: Stalking Sapling
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 655, 1, tpz.regime.type.GROUNDS)
end

return entity
