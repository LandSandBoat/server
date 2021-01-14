-----------------------------------
-- Area: Crawlers' Nest
--  Mob: Helm Beetle
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 692, 1, tpz.regime.type.GROUNDS)
end

return entity
