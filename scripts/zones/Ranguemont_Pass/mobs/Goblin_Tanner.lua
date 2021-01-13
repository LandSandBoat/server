-----------------------------------
-- Area: Ranguemont Pass
--  Mob: Goblin Tanner
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 609, 1, tpz.regime.type.GROUNDS)
end

return entity
