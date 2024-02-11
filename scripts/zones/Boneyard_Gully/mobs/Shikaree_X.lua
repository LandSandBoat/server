-----------------------------------
-- Area: Boneyard_Gully
--  Mob: Shikaree X
-----------------------------------
local entity = {}

entity.onMobEngage = function(mob, target)
    SpawnMob(mob:getID() + 2)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
