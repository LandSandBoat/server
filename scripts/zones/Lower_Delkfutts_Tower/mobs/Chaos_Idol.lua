-----------------------------------
-- Area: Lower Delkfutt's Tower
--  Mob: Chaos Idol
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 779, 2, tpz.regime.type.GROUNDS)
end

return entity
