-----------------------------------
-- Area: Inner Horutoto Ruins
--  Mob: Will-o-the-Wisp
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 650, 2, tpz.regime.type.GROUNDS)
end

return entity
