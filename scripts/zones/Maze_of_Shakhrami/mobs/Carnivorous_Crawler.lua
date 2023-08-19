-----------------------------------
-- Area: Maze of Shakhrami
--  Mob: Carnivorous Crawler
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 697, 2, xi.regime.type.GROUNDS)
end

return entity
