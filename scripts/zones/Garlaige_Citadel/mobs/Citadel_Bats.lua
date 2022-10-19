-----------------------------------
-- Area: Garlaige Citadel
--  Mob: Citadel Bats
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 705, 2, xi.regime.type.GROUNDS)
end

return entity
