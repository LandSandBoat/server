-----------------------------------
-- Area: Ordelle's Caves
--  Mob: Stroper
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    xi.regime.checkRegime(player, mob, 660, 2, xi.regime.type.GROUNDS)
end

return entity
