-----------------------------------
-- Area: RuAun Gardens
--  Mob: Water Elemental
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 146, 3, tpz.regime.type.FIELDS)
end

return entity
