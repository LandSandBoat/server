-----------------------------------
-- Area: Outer Horutoto Ruins
--  Mob: Eight of Coins
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 667, 4, xi.regime.type.GROUNDS)
end

return entity
