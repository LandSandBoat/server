-----------------------------------
-- Area: Labyrinth of Onzozo
--  Mob: Cockatrice
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 772, 1, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 773, 2, xi.regime.type.GROUNDS)
end

return entity
