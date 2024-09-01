-----------------------------------
-- Area: West Ronfaure
--  Mob: Wild Sheep
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 56, 1, xi.regime.type.FIELDS)
end

return entity
