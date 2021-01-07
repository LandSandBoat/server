-----------------------------------
-- Area: Ranguemont Pass
--  Mob: Ooze
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 603, 2, tpz.regime.type.GROUNDS)
end

return entity
