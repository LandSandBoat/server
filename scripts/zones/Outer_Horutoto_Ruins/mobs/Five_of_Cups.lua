-----------------------------------
-- Area: Outer Horutoto Ruins
--  Mob: Five of Cups
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 664, 1, xi.regime.type.GROUNDS)
end

return entity
