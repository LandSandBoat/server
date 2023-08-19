-----------------------------------
-- Area: Korroloka Tunnel
--  Mob: Thread Leech
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 730, 1, xi.regime.type.GROUNDS)
end

return entity
