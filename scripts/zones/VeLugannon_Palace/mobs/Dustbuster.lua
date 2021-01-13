-----------------------------------
-- Area: Ve'Lugannon Palace
--  Mob: Dustbuster
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 743, 1, tpz.regime.type.GROUNDS)
    tpz.regime.checkRegime(player, mob, 745, 1, tpz.regime.type.GROUNDS)
end

return entity
