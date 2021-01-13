-----------------------------------
-- Area: Dangruf Wadi
--  Mob: Goblin Healer
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 640, 1, tpz.regime.type.GROUNDS)
    tpz.regime.checkRegime(player, mob, 644, 2, tpz.regime.type.GROUNDS)
end

return entity
