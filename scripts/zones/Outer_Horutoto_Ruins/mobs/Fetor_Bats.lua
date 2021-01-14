-----------------------------------
-- Area: Outer Horutoto Ruins
--  Mob: Fetor Bats
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 669, 1, tpz.regime.type.GROUNDS)
end

return entity
