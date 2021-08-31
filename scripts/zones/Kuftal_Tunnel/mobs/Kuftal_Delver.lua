-----------------------------------
-- Area: Kuftal Tunnel
--  Mob: Kuftal Delver
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    xi.regime.checkRegime(player, mob, 742, 1, xi.regime.type.GROUNDS)
end

return entity
