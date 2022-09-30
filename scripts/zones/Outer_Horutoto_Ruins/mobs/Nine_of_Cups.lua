-----------------------------------
-- Area: Outer Horutoto Ruins
--  Mob: Nine of Cups
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 668, 1, xi.regime.type.GROUNDS)
end

return entity
