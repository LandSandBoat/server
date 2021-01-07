-----------------------------------
-- Area: Middle Delkfutt's Tower
--  Mob: Stirge
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 782, 2, tpz.regime.type.GROUNDS)
    tpz.regime.checkRegime(player, mob, 783, 2, tpz.regime.type.GROUNDS)
end

return entity
