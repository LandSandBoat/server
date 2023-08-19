-----------------------------------
-- Area: Maze of Shakhrami
--  Mob: Labyrinth Scorpion
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 700, 2, xi.regime.type.GROUNDS)
end

return entity
