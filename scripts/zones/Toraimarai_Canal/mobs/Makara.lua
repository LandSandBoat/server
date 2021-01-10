-----------------------------------
-- Area: Toraimarai Canal
--  Mob: Makara
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 618, 2, tpz.regime.type.GROUNDS)
end

return entity
