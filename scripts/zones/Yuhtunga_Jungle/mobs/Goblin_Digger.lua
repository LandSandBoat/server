-----------------------------------
-- Area: Yuhtunga Jungle
--  Mob: Goblin Digger
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 125, 2, xi.regime.type.FIELDS)
end

return entity
