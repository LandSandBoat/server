-----------------------------------
-- Area: Zeruhn Mines (172)
--  Mob: Burrower Worm
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 629, 2, tpz.regime.type.GROUNDS)
end

return entity
