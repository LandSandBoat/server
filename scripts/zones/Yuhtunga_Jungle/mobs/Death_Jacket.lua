-----------------------------------
-- Area: Yuhtunga Jungle
--  Mob: Death Jacket
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 125, 1, xi.regime.type.FIELDS)
end

return entity
