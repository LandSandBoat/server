-----------------------------------
-- Area: Middle Delkfutt's Tower
--  Mob: Goblin Furrier
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 782, 1, tpz.regime.type.GROUNDS)
    tpz.regime.checkRegime(player, mob, 784, 1, tpz.regime.type.GROUNDS)
end

return entity
