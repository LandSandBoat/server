-----------------------------------
-- Area: Korroloka Tunnel
--  Mob: Gigas Stonemason
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 733, 1, tpz.regime.type.GROUNDS)
end

return entity
