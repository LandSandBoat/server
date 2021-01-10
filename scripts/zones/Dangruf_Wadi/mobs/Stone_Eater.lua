-----------------------------------
-- Area: Dangruf Wadi
--  Mob: Stone Eater
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 639, 1, tpz.regime.type.GROUNDS)
end

return entity
