-----------------------------------
-- Area: Yhoator Jungle
--  Mob: Tonberry Jinxer
-----------------------------------
mixins = { require("scripts/mixins/families/tonberry") }
require("scripts/globals/regimes")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 133, 1, xi.regime.type.FIELDS)
end

return entity
