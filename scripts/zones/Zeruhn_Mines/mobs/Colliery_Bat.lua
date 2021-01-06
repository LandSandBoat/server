-----------------------------------
-- Area: Zeruhn Mines (172)
--  Mob: Colliery Bat
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 628, 1, tpz.regime.type.GROUNDS)
    tpz.regime.checkRegime(player, mob, 629, 1, tpz.regime.type.GROUNDS)
    tpz.regime.checkRegime(player, mob, 630, 1, tpz.regime.type.GROUNDS)
end

return entity
