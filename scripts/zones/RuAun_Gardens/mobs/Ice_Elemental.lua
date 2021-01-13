-----------------------------------
-- Area: RuAun Gardens
--  Mob: Ice Elemental
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 146, 1, tpz.regime.type.FIELDS)
end

return entity
