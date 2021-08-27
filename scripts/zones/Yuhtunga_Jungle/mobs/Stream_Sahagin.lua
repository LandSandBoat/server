-----------------------------------
-- Area: Yuhtunga Jungle
--  Mob: Stream Sahagin
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    xi.regime.checkRegime(player, mob, 127, 1, xi.regime.type.FIELDS)
end

return entity
