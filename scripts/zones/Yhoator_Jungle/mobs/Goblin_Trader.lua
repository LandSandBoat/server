-----------------------------------
-- Area: Yhoator Jungle
--  Mob: Goblin Trader
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    xi.regime.checkRegime(player, mob, 129, 2, xi.regime.type.FIELDS)
end

return entity
