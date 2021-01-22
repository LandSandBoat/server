-----------------------------------
-- Area: Zeruhn Mines (172)
--  Mob: Ding Bats
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 626, 1, tpz.regime.type.GROUNDS)
end

return entity
