-----------------------------------
-- Area: Korroloka Tunnel
--  Mob: Combat
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 728, 2, tpz.regime.type.GROUNDS)
end

return entity
