-----------------------------------
-- Area: Ve'Lugannon Palace
--  Mob: Mystic Weapon
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 743, 1, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 744, 1, xi.regime.type.GROUNDS)
end

return entity
