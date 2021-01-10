-----------------------------------
-- Area: Outer Horutoto Ruins
--  Mob: Six of Batons
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 665, 2, tpz.regime.type.GROUNDS)
end

return entity
