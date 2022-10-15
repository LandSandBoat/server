-----------------------------------
-- Area: Toraimarai Canal
--  Mob: Poroggo Excavator
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 625, 2, xi.regime.type.GROUNDS)
end

return entity
