-----------------------------------
-- Area: Outer Horutoto Ruins
--  Mob: Five of Swords
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 664, 3, xi.regime.type.GROUNDS)
end

return entity
