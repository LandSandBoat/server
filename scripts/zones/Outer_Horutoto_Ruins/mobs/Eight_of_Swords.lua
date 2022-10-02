-----------------------------------
-- Area: Outer Horutoto Ruins
--  Mob: Eight of Swords
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 667, 3, xi.regime.type.GROUNDS)
end

return entity
