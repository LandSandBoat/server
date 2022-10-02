-----------------------------------
-- Area: Yuhtunga Jungle
--  Mob: Meww the Turtlerider
-----------------------------------
mixins = { require("scripts/mixins/job_special") }
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 127, 1, xi.regime.type.FIELDS)
end

return entity
