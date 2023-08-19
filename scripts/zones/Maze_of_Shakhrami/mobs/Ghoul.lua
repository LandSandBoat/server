-----------------------------------
-- Area: Maze of Shakhrami
--  Mob: Ghoul
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 697, 1, xi.regime.type.GROUNDS)
end

return entity
