-----------------------------------
-- Area: Toraimarai Canal
--  Mob: Drowned Bones
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    xi.regime.checkRegime(player, mob, 624, 2, xi.regime.type.GROUNDS)
end

return entity
