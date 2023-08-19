-----------------------------------
-- Area: Labyrinth of Onzozo
--  Mob: Goblin Reaper
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 771, 2, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 772, 2, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 774, 2, xi.regime.type.GROUNDS)
end

return entity
