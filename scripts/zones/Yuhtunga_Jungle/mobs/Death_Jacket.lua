-----------------------------------
-- Area: Yuhtunga Jungle
--  Mob: Death Jacket
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 125, 1, tpz.regime.type.FIELDS)
end

return entity
