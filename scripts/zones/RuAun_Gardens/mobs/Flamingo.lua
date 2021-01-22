-----------------------------------
-- Area: RuAun Gardens
--  Mob: Flamingo
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 142, 1, tpz.regime.type.FIELDS)
end

return entity
