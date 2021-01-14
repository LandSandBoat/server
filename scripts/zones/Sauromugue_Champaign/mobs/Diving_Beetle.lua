-----------------------------------
-- Area: Sauromugue Champaign
--  Mob: Diving Beetle
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 40, 2, tpz.regime.type.FIELDS)
end

return entity
