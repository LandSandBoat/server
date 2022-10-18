-----------------------------------
-- Area: Den of Rancor
--  Mob: Puck
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 802, 2, xi.regime.type.GROUNDS)
end

return entity
