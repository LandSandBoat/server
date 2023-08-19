-----------------------------------
-- Area: Outer Horutoto Ruins
--  Mob: Nine of Swords
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 668, 3, xi.regime.type.GROUNDS)
end

return entity
