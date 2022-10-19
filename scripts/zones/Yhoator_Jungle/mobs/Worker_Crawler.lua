-----------------------------------
-- Area: Yhoator Jungle
--  Mob: Worker Crawler
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 132, 1, xi.regime.type.FIELDS)
end

return entity
