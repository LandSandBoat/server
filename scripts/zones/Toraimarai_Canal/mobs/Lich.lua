-----------------------------------
-- Area: Toraimarai Canal
--  Mob: Lich
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 619, 2, tpz.regime.type.GROUNDS)
end

return entity
