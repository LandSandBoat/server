-----------------------------------
-- Area: Outer Horutoto Ruins
--  Mob: Nine of Swords
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 668, 3, tpz.regime.type.GROUNDS)
end

return entity
