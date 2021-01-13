-----------------------------------
-- Area: Crawlers' Nest
--  Mob: Witch Hazel
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 689, 2, tpz.regime.type.GROUNDS)
end

return entity
