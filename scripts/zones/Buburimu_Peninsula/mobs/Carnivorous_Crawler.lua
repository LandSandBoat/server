-----------------------------------
-- Area: Buburimu Peninsula
--  Mob: Carnivorous Crawler
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 33, 1, xi.regime.type.FIELDS)
    xi.regime.checkRegime(player, mob, 34, 2, xi.regime.type.FIELDS)
end

return entity
