-----------------------------------
-- Area: Dynamis - Buburimu
--  Mob: Avatar Idol
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.dynamis.timeExtensionOnDeath(mob, player, optParams)
end

return entity
