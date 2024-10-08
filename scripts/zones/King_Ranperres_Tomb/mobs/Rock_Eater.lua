-----------------------------------
-- Area: King Ranperres Tomb
--  Mob: Rock Eater
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 634, 2, xi.regime.type.GROUNDS)
end

return entity
