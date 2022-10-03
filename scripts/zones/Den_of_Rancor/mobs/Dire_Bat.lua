-----------------------------------
-- Area: Den of Rancor
--  Mob: Dire Bat
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 796, 1, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 797, 1, xi.regime.type.GROUNDS)
end

return entity
