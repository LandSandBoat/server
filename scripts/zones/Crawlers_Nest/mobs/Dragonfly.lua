-----------------------------------
-- Area: Crawlers' Nest
--  Mob: Dragonfly
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 691, 3, xi.regime.type.GROUNDS)
end

return entity
