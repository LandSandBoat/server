-----------------------------------
-- Area: RuAun Gardens
--  Mob: Thunder Elemental
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 145, 3, tpz.regime.type.FIELDS)
end

return entity
