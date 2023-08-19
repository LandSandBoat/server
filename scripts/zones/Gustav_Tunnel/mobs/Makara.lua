-----------------------------------
-- Area: Gustav Tunnel
--  Mob: Makara
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 764, 2, xi.regime.type.GROUNDS)
end

return entity
