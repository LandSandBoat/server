-----------------------------------
-- Area: Jugner Forest
--  Mob: Jugner Funguar
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 13, 1, xi.regime.type.FIELDS)
    xi.regime.checkRegime(player, mob, 14, 1, xi.regime.type.FIELDS)
end

return entity
