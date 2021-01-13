-----------------------------------
-- Area: Korroloka Tunnel
--  Mob: Spool Leech
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 734, 2, tpz.regime.type.GROUNDS)
end

return entity
