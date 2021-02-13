-----------------------------------
-- Area: Garlaige Citadel
--  Mob: Fallen Officer
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 703, 2, tpz.regime.type.GROUNDS)
end

return entity
