-----------------------------------
-- Area: Riverne - Site A01
--  Mob: Aiatar
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    UpdateNMSpawnPoint(mob:getID())
end

return entity
