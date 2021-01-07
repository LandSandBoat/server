-----------------------------------
-- Area: Outer Horutoto Ruins
--  Mob: Nine of Cups
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 668, 1, tpz.regime.type.GROUNDS)
end

return entity
