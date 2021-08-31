-----------------------------------
-- Area: Ranguemont Pass
--  Mob: Goblin Tanner
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    xi.regime.checkRegime(player, mob, 609, 1, xi.regime.type.GROUNDS)
end

return entity
