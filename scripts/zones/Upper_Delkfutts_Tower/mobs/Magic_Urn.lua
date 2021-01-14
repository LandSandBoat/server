-----------------------------------
-- Area: Upper Delkfutt's Tower
--  Mob: Magic Urn
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 788, 3, tpz.regime.type.GROUNDS)
    tpz.regime.checkRegime(player, mob, 789, 3, tpz.regime.type.GROUNDS)
end

return entity
