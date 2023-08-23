-----------------------------------
-- Area: Maze of Shakhrami
--  Mob: Abyss Worm
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 699, 1, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 700, 1, xi.regime.type.GROUNDS)
end

return entity
