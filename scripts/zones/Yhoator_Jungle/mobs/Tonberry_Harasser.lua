-----------------------------------
-- Area: Yhoator Jungle
--  Mob: Tonberry Harasser
-----------------------------------
mixins = {require("scripts/mixins/families/tonberry")}
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.regime.checkRegime(player, mob, 133, 1, tpz.regime.type.FIELDS)
end

return entity
