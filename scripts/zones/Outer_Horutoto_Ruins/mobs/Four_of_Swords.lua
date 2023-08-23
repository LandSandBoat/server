-----------------------------------
-- Area: Outer Horutoto Ruins
--  Mob: Four of Swords
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 663, 3, xi.regime.type.GROUNDS)
end

return entity
