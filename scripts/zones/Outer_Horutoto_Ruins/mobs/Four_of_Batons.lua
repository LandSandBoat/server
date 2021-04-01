-----------------------------------
-- Area: Outer Horutoto Ruins
--  Mob: Four of Batons
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    xi.regime.checkRegime(player, mob, 663, 2, xi.regime.type.GROUNDS)
end

return entity
