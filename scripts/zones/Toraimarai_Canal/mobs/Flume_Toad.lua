-----------------------------------
-- Area: Toraimarai Canal
--  Mob: Flume Toad
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 625, 1, tpz.regime.type.GROUNDS)
end

return entity
