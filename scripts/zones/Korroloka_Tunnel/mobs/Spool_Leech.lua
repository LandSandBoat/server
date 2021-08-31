-----------------------------------
-- Area: Korroloka Tunnel
--  Mob: Spool Leech
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    xi.regime.checkRegime(player, mob, 734, 2, xi.regime.type.GROUNDS)
end

return entity
