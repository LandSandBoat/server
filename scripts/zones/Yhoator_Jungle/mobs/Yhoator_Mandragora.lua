-----------------------------------
-- Area: Yhoator Jungle
--  Mob: Yhoator Mandragora
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 130, 1, tpz.regime.type.FIELDS)
end

return entity
