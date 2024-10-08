-----------------------------------
-- Area: Maze of Shakhrami
--  Mob: Warren Bat
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 702, 1, xi.regime.type.GROUNDS)
end

return entity
