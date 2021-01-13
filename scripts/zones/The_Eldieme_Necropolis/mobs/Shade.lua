-----------------------------------
-- Area: The Eldieme Necropolis
--  Mob: Shade
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 672, 1, tpz.regime.type.GROUNDS)
    tpz.regime.checkRegime(player, mob, 673, 1, tpz.regime.type.GROUNDS)
end

return entity
