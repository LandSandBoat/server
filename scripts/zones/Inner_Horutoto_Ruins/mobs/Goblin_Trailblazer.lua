-----------------------------------
-- Area: Inner Horutoto Ruins
--  Mob: Goblin Trailblazer
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 651, 2, xi.regime.type.GROUNDS)
end

return entity
