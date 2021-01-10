-----------------------------------
-- Area: Kuftal Tunnel
--  Mob: Kuftal Digger
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 739, 1, tpz.regime.type.GROUNDS)
end

return entity
