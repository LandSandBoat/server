-----------------------------------
-- Area: Behemoths Dominion
--  Mob: Lesser Gaylas
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 101, 1, tpz.regime.type.FIELDS)
    tpz.regime.checkRegime(player, mob, 102, 1, tpz.regime.type.FIELDS)
end

return entity
