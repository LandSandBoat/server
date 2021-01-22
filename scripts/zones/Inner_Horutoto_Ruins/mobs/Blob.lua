-----------------------------------
-- Area: Inner Horutoto Ruins
--  Mob: Blob
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 649, 2, tpz.regime.type.GROUNDS)
end

return entity
