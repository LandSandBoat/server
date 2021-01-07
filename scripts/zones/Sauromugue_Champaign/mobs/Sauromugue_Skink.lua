-----------------------------------
-- Area: Sauromugue Champaign
--  Mob: Sauromugue Skink
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 97, 1, tpz.regime.type.FIELDS)
    tpz.regime.checkRegime(player, mob, 99, 1, tpz.regime.type.FIELDS)
end

return entity
