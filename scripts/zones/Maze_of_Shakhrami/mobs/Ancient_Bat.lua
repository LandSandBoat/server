-----------------------------------
-- Area: Maze of Shakhrami
--  Mob: Ancient Bat
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 698, 2, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 699, 2, xi.regime.type.GROUNDS)
end

return entity
