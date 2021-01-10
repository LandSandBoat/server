-----------------------------------
-- Area: King Ranperres Tomb
--  Mob: Ossuary Worm
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 636, 1, tpz.regime.type.GROUNDS)
end

return entity
