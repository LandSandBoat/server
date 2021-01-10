-----------------------------------
-- Area: Inner Horutoto Ruins
--  Mob: Skinnymajinx
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 654, 2, tpz.regime.type.GROUNDS)
end

return entity
