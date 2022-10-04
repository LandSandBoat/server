-----------------------------------
-- Area: Buburimu Peninsula
--  Mob: Poison Leech
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 35, 1, xi.regime.type.FIELDS)
end

return entity
