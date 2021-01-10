-----------------------------------
-- Area: North Gustaberg
--  Mob: Ornery Sheep
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 59, 2, tpz.regime.type.FIELDS)
end

return entity
