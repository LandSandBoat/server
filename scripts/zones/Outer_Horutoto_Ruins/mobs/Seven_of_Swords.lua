-----------------------------------
-- Area: Outer Horutoto Ruins
--  Mob: Seven of Swords
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 666, 3, xi.regime.type.GROUNDS)
end

return entity
