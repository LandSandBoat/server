-----------------------------------
-- Area: Ordelle's Caves
--  Mob: Will-o-the-Wisp
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 657, 2, tpz.regime.type.GROUNDS)
end

return entity
