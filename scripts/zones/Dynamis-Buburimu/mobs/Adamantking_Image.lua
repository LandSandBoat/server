-----------------------------------
-- Area: Dynamis - Buburimu
--  Mob: Adamantking Image
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.dynamis.timeExtensionOnDeath(mob, player, optParams)
end

return entity
