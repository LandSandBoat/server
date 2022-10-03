-----------------------------------
-- Area: Ordelle's Caves
--  Mob: Vorpal Bunny
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 658, 2, xi.regime.type.GROUNDS)
end

return entity
