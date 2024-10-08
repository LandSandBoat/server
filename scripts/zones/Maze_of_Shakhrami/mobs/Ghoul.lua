-----------------------------------
-- Area: Maze of Shakhrami
--  Mob: Ghoul
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 697, 1, xi.regime.type.GROUNDS)
end

return entity
