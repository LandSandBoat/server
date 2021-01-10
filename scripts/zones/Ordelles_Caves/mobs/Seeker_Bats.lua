-----------------------------------
-- Area: Ordelle's Caves
--  Mob: Seeker Bats
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 658, 1, tpz.regime.type.GROUNDS)
end

return entity
