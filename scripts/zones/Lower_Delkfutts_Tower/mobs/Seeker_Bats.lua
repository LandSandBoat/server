-----------------------------------
-- Area: Lower Delkfutt's Tower
--  Mob: Seeker Bats
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 777, 1, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 778, 1, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 779, 1, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 780, 1, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 781, 1, xi.regime.type.GROUNDS)
end

return entity
