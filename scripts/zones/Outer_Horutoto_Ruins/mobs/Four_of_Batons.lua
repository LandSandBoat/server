-----------------------------------
-- Area: Outer Horutoto Ruins
--  Mob: Four of Batons
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 663, 2, xi.regime.type.GROUNDS)
end

return entity
