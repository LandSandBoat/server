-----------------------------------
-- Area: Garlaige Citadel
--  Mob: Chamber Beetle
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 707, 2, xi.regime.type.GROUNDS)
end

return entity
