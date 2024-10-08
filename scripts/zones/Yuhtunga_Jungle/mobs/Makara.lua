-----------------------------------
-- Area: Yuhtunga Jungle
--  Mob: Makara
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 127, 2, xi.regime.type.FIELDS)
end

return entity
