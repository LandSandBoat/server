-----------------------------------
-- Area: Inner Horutoto Ruins
--  Mob: Goblin Weaver
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    xi.regime.checkRegime(player, mob, 648, 2, xi.regime.type.GROUNDS)
end

return entity
