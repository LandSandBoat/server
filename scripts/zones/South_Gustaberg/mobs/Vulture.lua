-----------------------------------
-- Area: South Gustaberg
--  Mob: Vulture
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

local entity = {}

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 78, 1, tpz.regime.type.FIELDS)
end

return entity
