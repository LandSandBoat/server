-----------------------------------
-- Area: Valley of Sorrows
--  Mob: Velociraptor
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 139, 1, xi.regime.type.FIELDS)
    xi.regime.checkRegime(player, mob, 140, 1, xi.regime.type.FIELDS)
end

return entity
