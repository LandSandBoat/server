-----------------------------------
-- Area: East Sarutabaruta
--  Mob: Bolster
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 92, 2, xi.regime.type.FIELDS)
    xi.regime.checkRegime(player, mob, 93, 2, xi.regime.type.FIELDS)
end

return entity
