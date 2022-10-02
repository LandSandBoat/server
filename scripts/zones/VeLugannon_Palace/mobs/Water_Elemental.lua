-----------------------------------
-- Area: Ve'Lugannon Palace
--  Mob: Water Elemental
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 748, 1, xi.regime.type.GROUNDS)
end

return entity
