-----------------------------------
-- Area: Labyrinth of Onzozo
--  Mob: Cockatrice
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 772, 1, tpz.regime.type.GROUNDS)
    tpz.regime.checkRegime(player, mob, 773, 2, tpz.regime.type.GROUNDS)
end

return entity
