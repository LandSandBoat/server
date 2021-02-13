-----------------------------------
-- Area: Toraimarai Canal
--  Mob: Fallen Knight
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 619, 1, tpz.regime.type.GROUNDS)
end

return entity
