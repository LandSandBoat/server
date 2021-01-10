-----------------------------------
-- Area: Upper Delkfutt's Tower
--  Mob: Incubus Bats
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 786, 3, tpz.regime.type.GROUNDS)
    tpz.regime.checkRegime(player, mob, 787, 3, tpz.regime.type.GROUNDS)
end

return entity
