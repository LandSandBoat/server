-----------------------------------
-- Area: The Boyahda Tree
--  Mob: Skimmer
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 723, 1, tpz.regime.type.GROUNDS)
end

return entity
