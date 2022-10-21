-----------------------------------
-- Area: Rolanberry Fields
--  Mob: Berry Grub
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 25, 2, xi.regime.type.FIELDS)
    xi.regime.checkRegime(player, mob, 86, 1, xi.regime.type.FIELDS)
    xi.regime.checkRegime(player, mob, 87, 1, xi.regime.type.FIELDS)
end

return entity
