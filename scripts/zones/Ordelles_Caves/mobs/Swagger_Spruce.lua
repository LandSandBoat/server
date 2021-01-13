-----------------------------------
-- Area: Ordelle's Caves
--  Mob: Swagger Spruce
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 662, 2, tpz.regime.type.GROUNDS)
end

return entity
