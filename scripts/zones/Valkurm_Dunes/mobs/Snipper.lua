-----------------------------------
-- Area: Valkurm Dunes
--  Mob: Snipper
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 8, 1, xi.regime.type.FIELDS)
    xi.regime.checkRegime(player, mob, 9, 2, xi.regime.type.FIELDS)
end

return entity
