-----------------------------------
-- Area: South Gustaberg
--  Mob: Stone Eater
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 77, 1, tpz.regime.type.FIELDS)
end

return entity
