-----------------------------------
-- Area: Boneyard_Gully
--  Mob: Shikaree X
-----------------------------------
local entity = {}

function onMobEngaged(mob, target)
    SpawnMob(mob:getID() + 2)
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
