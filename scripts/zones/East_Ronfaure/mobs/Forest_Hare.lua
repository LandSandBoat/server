-----------------------------------
-- Area: East Ronfaure
--  Mob: Forest Hare
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 66, 1, xi.regime.type.FIELDS)
end

return entity
