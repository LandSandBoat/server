-----------------------------------
-- Area: Jugner Forest
--  Mob: Forest Tiger
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 14, 2, tpz.regime.type.FIELDS)
end

return entity
