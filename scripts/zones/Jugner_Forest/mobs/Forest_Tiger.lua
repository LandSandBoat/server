-----------------------------------
-- Area: Jugner Forest
--  Mob: Forest Tiger
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 14, 2, xi.regime.type.FIELDS)
end

return entity
