-----------------------------------
-- Area: Den of Rancor
--  Mob: Puck
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 802, 2, tpz.regime.type.GROUNDS)
end

return entity
