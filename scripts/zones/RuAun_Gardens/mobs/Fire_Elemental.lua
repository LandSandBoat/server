-----------------------------------
-- Area: RuAun Gardens
--  Mob: Fire Elemental
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 145, 1, tpz.regime.type.FIELDS)
end

return entity
