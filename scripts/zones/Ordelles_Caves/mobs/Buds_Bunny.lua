-----------------------------------
-- Area: Ordelle's Caves
--  Mob: Buds Bunny
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 661, 1, xi.regime.type.GROUNDS)
end

return entity
