-----------------------------------
-- Area: Ranguemont Pass
--  Mob: Goblin Chaser
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 608, 2, xi.regime.type.GROUNDS)
end

return entity
