-----------------------------------
-- Area: Riverne - Site A01
--  Mob: Aiatar
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    UpdateNMSpawnPoint(mob:getID())
end

return entity
