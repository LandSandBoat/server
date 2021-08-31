-----------------------------------
-- Area: Buburimu Peninsula
--  Mob: Mighty Rarab
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    xi.regime.checkRegime(player, mob, 32, 2, xi.regime.type.FIELDS)
end

return entity
