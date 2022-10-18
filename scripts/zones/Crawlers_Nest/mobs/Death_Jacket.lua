-----------------------------------
-- Area: Crawlers' Nest
--  Mob: Death Jacket
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 687, 2, xi.regime.type.GROUNDS)
end

return entity
