-----------------------------------
-- Area: The Sanctuary of Zi'Tah
--  Mob: Noble Mold
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 115, 1, xi.regime.type.FIELDS)
    xi.regime.checkRegime(player, mob, 116, 2, xi.regime.type.FIELDS)
end

return entity
