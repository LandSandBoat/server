-----------------------------------
-- Area: Crawlers' Nest
--  Mob: Exoray
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    xi.regime.checkRegime(player, mob, 690, 1, xi.regime.type.GROUNDS)
end

return entity
