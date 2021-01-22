-----------------------------------
-- Area: Inner Horutoto Ruins
--  Mob: Deathwatch Beetle
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 652, 1, tpz.regime.type.GROUNDS)
end

return entity
