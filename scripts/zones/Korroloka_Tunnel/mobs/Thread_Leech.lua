-----------------------------------
-- Area: Korroloka Tunnel
--  Mob: Thread Leech
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    xi.regime.checkRegime(player, mob, 730, 1, xi.regime.type.GROUNDS)
end

return entity
