-----------------------------------
-- Area: Labyrinth of Onzozo
--  Mob: Babaulas
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    xi.regime.checkRegime(player, mob, 776, 1, xi.regime.type.GROUNDS)
end

return entity
