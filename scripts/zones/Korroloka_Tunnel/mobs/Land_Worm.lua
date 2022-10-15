-----------------------------------
-- Area: Korroloka Tunnel
--  Mob: Land Worm
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 727, 1, xi.regime.type.GROUNDS)
end

return entity
