-----------------------------------
-- Area: Ranguemont Pass
--  Mob: Blade Bat
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 602, 2, tpz.regime.type.GROUNDS)
end

return entity
