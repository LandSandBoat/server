-----------------------------------
-- Area: Outer Horutoto Ruins
--  Mob: Fuligo
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 669, 2, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 670, 2, xi.regime.type.GROUNDS)
end

return entity
