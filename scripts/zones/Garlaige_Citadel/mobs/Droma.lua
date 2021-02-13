-----------------------------------
-- Area: Garlaige Citadel
--  Mob: Droma
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 707, 1, tpz.regime.type.GROUNDS)
end

return entity
