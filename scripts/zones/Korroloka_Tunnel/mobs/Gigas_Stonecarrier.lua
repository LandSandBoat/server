-----------------------------------
-- Area: Korroloka Tunnel
--  Mob: Gigas Stonecarrier
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 733, 1, xi.regime.type.GROUNDS)
end

return entity
