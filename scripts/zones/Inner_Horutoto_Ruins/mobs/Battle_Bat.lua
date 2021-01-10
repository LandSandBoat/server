-----------------------------------
-- Area: Inner Horutoto Ruins
--  Mob: Battle Bat
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 649, 1, tpz.regime.type.GROUNDS)
end

return entity
