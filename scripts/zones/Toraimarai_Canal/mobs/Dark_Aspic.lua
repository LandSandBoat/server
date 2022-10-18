-----------------------------------
-- Area: Toraimarai Canal
--  Mob: Dark Aspic
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 619, 3, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 620, 1, xi.regime.type.GROUNDS)
end

return entity
