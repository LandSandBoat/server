-----------------------------------
-- Area: Crawlers' Nest
--  Mob: Dancing Jewel
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 694, 1, tpz.regime.type.GROUNDS)
end

return entity
