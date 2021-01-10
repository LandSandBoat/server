-----------------------------------
-- Area: Ranguemont Pass
--  Mob: Stirge
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 606, 1, tpz.regime.type.GROUNDS)
end

return entity
