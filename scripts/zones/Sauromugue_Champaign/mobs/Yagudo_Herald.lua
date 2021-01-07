-----------------------------------
-- Area: Sauromugue Champaign
--  Mob: Yagudo Herald
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 99, 2, tpz.regime.type.FIELDS)
end

return entity
