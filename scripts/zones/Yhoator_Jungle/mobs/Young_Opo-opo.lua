-----------------------------------
-- Area: Yhoator Jungle
--  Mob: Young Opo-opo
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 131, 1, tpz.regime.type.FIELDS)
    tpz.regime.checkRegime(player, mob, 132, 2, tpz.regime.type.FIELDS)
end

return entity
