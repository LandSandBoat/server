-----------------------------------
-- Area: Kuftal Tunnel
--  Mob: Ovinnik
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    xi.regime.checkRegime(player, mob, 741, 1, xi.regime.type.GROUNDS)
end

return entity
