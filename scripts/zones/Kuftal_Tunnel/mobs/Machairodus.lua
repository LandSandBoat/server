-----------------------------------
-- Area: Kuftal Tunnel
--  Mob: Machairodus
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 742, 2, xi.regime.type.GROUNDS)
end

return entity
