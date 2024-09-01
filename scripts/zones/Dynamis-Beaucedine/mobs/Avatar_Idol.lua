-----------------------------------
-- Area: Dynamis - Beaucedine
--  Mob: Avatar Idol
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.dynamis.timeExtensionOnDeath(mob, player, optParams)
end

return entity
