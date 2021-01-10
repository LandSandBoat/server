-----------------------------------
-- Area: Outer Horutoto Ruins
--  Mob: Seven of Swords
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 666, 3, tpz.regime.type.GROUNDS)
end

return entity
