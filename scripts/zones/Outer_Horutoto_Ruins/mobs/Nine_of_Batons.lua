-----------------------------------
-- Area: Outer Horutoto Ruins
--  Mob: Nine of Batons
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 668, 2, xi.regime.type.GROUNDS)
end

return entity
