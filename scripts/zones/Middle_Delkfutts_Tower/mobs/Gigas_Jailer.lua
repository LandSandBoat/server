-----------------------------------
-- Area: Middle Delkfutt's Tower
--  Mob: Gigas Jailer
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 783, 1, tpz.regime.type.GROUNDS)
    tpz.regime.checkRegime(player, mob, 784, 2, tpz.regime.type.GROUNDS)
end

return entity
