-----------------------------------
-- Area: Ranguemont Pass
--  Mob: Goblin Artificer
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 609, 2, tpz.regime.type.GROUNDS)
end

return entity
