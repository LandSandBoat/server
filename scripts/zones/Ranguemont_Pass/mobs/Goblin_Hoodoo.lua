-----------------------------------
-- Area: Ranguemont Pass
--  Mob: Goblin Hoodoo
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 608, 1, xi.regime.type.GROUNDS)
end

return entity
