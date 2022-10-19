-----------------------------------
-- Area: Cape Teriggan
--  Mob: Velociraptor
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 106, 2, xi.regime.type.FIELDS)
    xi.regime.checkRegime(player, mob, 107, 1, xi.regime.type.FIELDS)
end

return entity
