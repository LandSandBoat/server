-----------------------------------
-- Area: Boneyard_Gully
--  Mob: Shikaree Z
-----------------------------------
local entity = {}

entity.onMobEngage = function(mob, target)
    SpawnMob(mob:getID() + 3)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
