-----------------------------------
-- Area: Maze of Shakhrami
--  Mob: Bleeder Leech
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 701, 2, xi.regime.type.GROUNDS)
end

return entity
