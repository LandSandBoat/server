-----------------------------------
-- Area: Toraimarai Canal
--  Mob: Stygian Pugil
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 621, 2, tpz.regime.type.GROUNDS)
end

return entity
