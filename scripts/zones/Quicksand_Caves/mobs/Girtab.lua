-----------------------------------
-- Area: Quicksand Caves
--  Mob: Girtab
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 818, 1, xi.regime.type.GROUNDS)
end

return entity
