-----------------------------------
-- Area: Quicksand Caves
--  Mob: Girtab
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 818, 1, tpz.regime.type.GROUNDS)
end

return entity
