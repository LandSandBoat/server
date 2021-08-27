-----------------------------------
-- Area: Ordelle's Caves
--  Mob: Goblin Ambusher
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    xi.regime.checkRegime(player, mob, 657, 1, xi.regime.type.GROUNDS)
end

return entity
