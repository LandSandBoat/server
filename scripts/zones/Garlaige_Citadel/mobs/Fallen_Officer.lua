-----------------------------------
-- Area: Garlaige Citadel
--  Mob: Fallen Officer
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 703, 2, xi.regime.type.GROUNDS)
end

return entity
