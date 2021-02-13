-----------------------------------
-- Area: Garlaige Citadel
--  Mob: Funnel Bats
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 706, 1, tpz.regime.type.GROUNDS)
end

return entity
