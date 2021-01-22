-----------------------------------
-- Area: Boneyard_Gully
--  Mob: Shikaree Z
-----------------------------------
local entity = {}

entity.onMobEngaged = function(mob, target)
    SpawnMob(mob:getID() + 3)
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
