-----------------------------------
-- Area: Yhoator Jungle
--  Mob: Tonberry Hexer
-----------------------------------
mixins = { require('scripts/mixins/families/tonberry') }
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 133, 1, xi.regime.type.FIELDS)
end

return entity
