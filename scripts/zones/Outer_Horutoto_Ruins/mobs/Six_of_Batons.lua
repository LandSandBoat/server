-----------------------------------
-- Area: Outer Horutoto Ruins
--  Mob: Six of Batons
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 665, 2, xi.regime.type.GROUNDS)
end

return entity
