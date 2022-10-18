-----------------------------------
-- Area: Korroloka Tunnel
--  Mob: Greater Pugil
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 731, 2, xi.regime.type.GROUNDS)
end

return entity
