-----------------------------------
-- Area: Quicksand Caves
--  Mob: Sand Spider
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 812, 1, xi.regime.type.GROUNDS)
end

return entity
