-----------------------------------
-- Area: Inner Horutoto Ruins
--  Mob: Goblin Thug
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 647, 2, tpz.regime.type.GROUNDS)
end

return entity
