-----------------------------------
-- Area: Garlaige Citadel
--  Mob: Donjon Bat
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 709, 1, xi.regime.type.GROUNDS)
end

return entity
