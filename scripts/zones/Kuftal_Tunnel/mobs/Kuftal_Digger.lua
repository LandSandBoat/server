-----------------------------------
-- Area: Kuftal Tunnel
--  Mob: Kuftal Digger
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 739, 1, xi.regime.type.GROUNDS)
end

return entity
