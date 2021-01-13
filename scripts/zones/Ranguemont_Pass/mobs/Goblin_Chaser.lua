-----------------------------------
-- Area: Ranguemont Pass
--  Mob: Goblin Chaser
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 608, 2, tpz.regime.type.GROUNDS)
end

return entity
