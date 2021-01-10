-----------------------------------
-- Area: Gusgen Mines
--  Mob: Ore Eater
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 681, 1, tpz.regime.type.GROUNDS)
end

return entity
