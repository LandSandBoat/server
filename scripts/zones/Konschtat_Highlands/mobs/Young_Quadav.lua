-----------------------------------
-- Area: Konschtat Highlands
--  Mob: Young Quadav
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 83, 1, xi.regime.type.FIELDS)
end

return entity
