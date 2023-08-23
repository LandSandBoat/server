-----------------------------------
-- Area: Yuhtunga Jungle
--  Mob: Goblin Smithy
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 125, 2, xi.regime.type.FIELDS)
end

return entity
