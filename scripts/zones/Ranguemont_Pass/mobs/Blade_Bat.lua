-----------------------------------
-- Area: Ranguemont Pass
--  Mob: Blade Bat
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    xi.regime.checkRegime(player, mob, 602, 2, xi.regime.type.GROUNDS)
end

return entity
