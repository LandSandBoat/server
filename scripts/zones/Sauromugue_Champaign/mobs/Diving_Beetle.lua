-----------------------------------
-- Area: Sauromugue Champaign
--  Mob: Diving Beetle
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    xi.regime.checkRegime(player, mob, 40, 2, xi.regime.type.FIELDS)
end

return entity
