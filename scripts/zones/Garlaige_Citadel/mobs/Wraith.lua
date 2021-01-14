-----------------------------------
-- Area: Garlaige Citadel
--  Mob: Wraith
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 708, 3, tpz.regime.type.GROUNDS)
end

return entity
