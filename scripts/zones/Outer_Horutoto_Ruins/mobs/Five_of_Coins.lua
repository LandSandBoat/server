-----------------------------------
-- Area: Outer Horutoto Ruins
--  Mob: Five of Coins
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 664, 4, xi.regime.type.GROUNDS)
end

return entity
