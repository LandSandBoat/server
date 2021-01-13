-----------------------------------
-- Area: Lower Delkfutt's Tower
--  Mob: Seeker Bats
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 777, 1, tpz.regime.type.GROUNDS)
    tpz.regime.checkRegime(player, mob, 778, 1, tpz.regime.type.GROUNDS)
    tpz.regime.checkRegime(player, mob, 779, 1, tpz.regime.type.GROUNDS)
    tpz.regime.checkRegime(player, mob, 780, 1, tpz.regime.type.GROUNDS)
    tpz.regime.checkRegime(player, mob, 781, 1, tpz.regime.type.GROUNDS)
end

return entity
