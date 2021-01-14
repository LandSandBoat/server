-----------------------------------
-- Area: Zeruhn Mines (172)
--  Mob: River Crab
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 627, 1, tpz.regime.type.GROUNDS)
end

return entity
