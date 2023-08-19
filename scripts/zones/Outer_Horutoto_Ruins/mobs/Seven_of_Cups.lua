-----------------------------------
-- Area: Outer Horutoto Ruins
--  Mob: Seven of Cups
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 666, 1, xi.regime.type.GROUNDS)
end

return entity
