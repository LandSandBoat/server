-----------------------------------
-- Area: Buburimu Peninsula
--  Mob: Ketos
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 62, 1, xi.regime.type.FIELDS)
end

return entity
