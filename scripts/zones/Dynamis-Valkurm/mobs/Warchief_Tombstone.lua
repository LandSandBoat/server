-----------------------------------
-- Area: Dynamis - Valkurm
--  Mob: Warchief Tombstone
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.dynamis.timeExtensionOnDeath(mob, player, optParams)
end

return entity
