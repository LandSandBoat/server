-----------------------------------
-- Area: Korroloka Tunnel
--  Mob: Lacerator
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 734, 1, tpz.regime.type.GROUNDS)
end

return entity
