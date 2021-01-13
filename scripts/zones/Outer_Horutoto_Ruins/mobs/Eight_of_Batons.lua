-----------------------------------
-- Area: Outer Horutoto Ruins
--  Mob: Eight of Batons
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 667, 2, tpz.regime.type.GROUNDS)
end

return entity
