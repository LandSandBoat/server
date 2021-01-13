-----------------------------------
-- Area: Crawlers' Nest
--  Mob: Dragonfly
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 691, 3, tpz.regime.type.GROUNDS)
end

return entity
