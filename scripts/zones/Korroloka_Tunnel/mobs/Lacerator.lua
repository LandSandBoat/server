-----------------------------------
-- Area: Korroloka Tunnel
--  Mob: Lacerator
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 734, 1, xi.regime.type.GROUNDS)
end

return entity
