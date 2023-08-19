-----------------------------------
-- Area: Korroloka Tunnel
--  Mob: Jelly
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 729, 2, xi.regime.type.GROUNDS)
end

return entity
