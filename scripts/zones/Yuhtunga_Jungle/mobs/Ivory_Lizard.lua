-----------------------------------
-- Area: Yuhtunga Jungle
--  Mob: Ivory Lizard
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 124, 2, xi.regime.type.FIELDS)
end

return entity
