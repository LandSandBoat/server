-----------------------------------
-- Area: Gustav Tunnel
--  Mob: Hawker
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 764, 1, xi.regime.type.GROUNDS)
end

return entity
