-----------------------------------
-- Area: Batallia Downs
--  Mob: Ba
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 15, 2, xi.regime.type.FIELDS)
    xi.regime.checkRegime(player, mob, 73, 2, xi.regime.type.FIELDS)
end

return entity
