-----------------------------------
-- Area: Ranguemont Pass
--  Mob: Wind Bats
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 602, 1, tpz.regime.type.GROUNDS)
end

return entity
