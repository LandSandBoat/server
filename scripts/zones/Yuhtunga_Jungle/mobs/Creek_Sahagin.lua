-----------------------------------
-- Area: Yuhtunga Jungle
--  Mob: Creek Sahagin
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 127, 1, tpz.regime.type.FIELDS)
end

return entity
