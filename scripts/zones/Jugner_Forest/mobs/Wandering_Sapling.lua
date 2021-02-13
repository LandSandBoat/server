-----------------------------------
-- Area: Jugner Forest
--  Mob: Wandering Sapling
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 58, 1, tpz.regime.type.FIELDS)
end

return entity
