-----------------------------------
-- Area: Ordelle's Caves
--  Mob: Goliath Beetle
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 660, 1, tpz.regime.type.GROUNDS)
end

return entity
