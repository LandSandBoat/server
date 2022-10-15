-----------------------------------
-- Area: Garlaige Citadel
--  Mob: Warden Beetle
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 710, 2, xi.regime.type.GROUNDS)
end

return entity
