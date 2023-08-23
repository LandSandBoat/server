-----------------------------------
-- Area: Upper Delkfutt's Tower
--  Mob: Magic Urn
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 788, 3, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 789, 3, xi.regime.type.GROUNDS)
end

return entity
