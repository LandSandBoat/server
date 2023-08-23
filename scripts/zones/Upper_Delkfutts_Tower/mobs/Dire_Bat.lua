-----------------------------------
-- Area: Upper Delkfutt's Tower
--  Mob: Dire Bat
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 786, 3, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 787, 3, xi.regime.type.GROUNDS)
end

return entity
