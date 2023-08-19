-----------------------------------
-- Area: Maze of Shakhrami
--  Mob: Combat
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 696, 2, xi.regime.type.GROUNDS)
end

return entity
