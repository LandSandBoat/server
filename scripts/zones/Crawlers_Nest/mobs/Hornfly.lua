-----------------------------------
-- Area: Crawlers' Nest
--  Mob: Hornfly
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    xi.regime.checkRegime(player, mob, 690, 2, xi.regime.type.GROUNDS)
end

return entity
