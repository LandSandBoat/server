-----------------------------------
-- Area: Kuftal Tunnel
--  Mob: Goblin Tamer
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 740, 2, xi.regime.type.GROUNDS)
end

return entity
