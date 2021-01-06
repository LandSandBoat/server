-----------------------------------
-- Area: Korroloka Tunnel
--  Mob: Seeker Bats
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 727, 2, tpz.regime.type.GROUNDS)
    tpz.regime.checkRegime(player, mob, 728, 1, tpz.regime.type.GROUNDS)
end

return entity
