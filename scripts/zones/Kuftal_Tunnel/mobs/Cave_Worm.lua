-----------------------------------
-- Area: Kuftal Tunnel
--  Mob: Cave Worm
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 737, 1, tpz.regime.type.GROUNDS)
end

return entity
