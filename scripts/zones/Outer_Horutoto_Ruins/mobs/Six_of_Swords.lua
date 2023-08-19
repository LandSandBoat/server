-----------------------------------
-- Area: Outer Horutoto Ruins
--  Mob: Six of Swords
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 665, 3, xi.regime.type.GROUNDS)
end

return entity
