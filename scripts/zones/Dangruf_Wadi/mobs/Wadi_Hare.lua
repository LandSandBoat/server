-----------------------------------
-- Area: Dangruf Wadi
--  Mob: Wadi Hare
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 641, 1, tpz.regime.type.GROUNDS)
end

return entity
