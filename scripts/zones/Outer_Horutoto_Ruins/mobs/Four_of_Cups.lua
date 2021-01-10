-----------------------------------
-- Area: Outer Horutoto Ruins
--  Mob: Four of Cups
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 663, 1, tpz.regime.type.GROUNDS)
end

return entity
