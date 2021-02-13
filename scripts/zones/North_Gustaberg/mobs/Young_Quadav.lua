-----------------------------------
-- Area: North Gustaberg
--  Mob: Young Quadav
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 19, 1, tpz.regime.type.FIELDS)
    tpz.regime.checkRegime(player, mob, 59, 1, tpz.regime.type.FIELDS)
end

return entity
