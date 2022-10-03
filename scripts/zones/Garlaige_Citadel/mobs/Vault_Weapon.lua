-----------------------------------
-- Area: Garlaige Citadel
--  Mob: Vault Weapon
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 705, 1, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 708, 2, xi.regime.type.GROUNDS)
end

return entity
