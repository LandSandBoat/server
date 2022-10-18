-----------------------------------
-- Area: East Sarutabaruta
--  Mob: Mandragora
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 89, 1, xi.regime.type.FIELDS)
end

return entity
