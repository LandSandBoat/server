-----------------------------------
-- Area: The Boyahda Tree
--  Mob: Bark Spider
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 719, 2, tpz.regime.type.GROUNDS)
end

return entity
