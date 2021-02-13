-----------------------------------
-- Area: Toraimarai Canal
--  Mob: Hell Bat
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 618, 1, tpz.regime.type.GROUNDS)
end

return entity
