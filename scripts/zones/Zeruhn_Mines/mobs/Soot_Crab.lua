-----------------------------------
-- Area: Zeruhn Mines (172)
--  Mob: Soot Crab
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 628, 2, tpz.regime.type.GROUNDS)
end

return entity
