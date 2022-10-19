-----------------------------------
-- Area: Toraimarai Canal
--  Mob: Hell Bat
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 618, 1, xi.regime.type.GROUNDS)
end

return entity
