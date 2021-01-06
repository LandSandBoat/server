-----------------------------------
-- Area: Qufim Island
--  Mob: Greater Pugil
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 43, 1, tpz.regime.type.FIELDS)
    tpz.regime.checkRegime(player, mob, 44, 2, tpz.regime.type.FIELDS)
    tpz.regime.checkRegime(player, mob, 45, 3, tpz.regime.type.FIELDS)
end

return entity
