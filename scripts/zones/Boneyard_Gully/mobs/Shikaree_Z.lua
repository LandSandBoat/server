-----------------------------------
-- Area: Boneyard_Gully
--  Mob: Shikaree Z
-----------------------------------

function onMobEngaged(mob, target)
    SpawnMob(mob:getID() + 3)
end

function onMobDeath(mob, player, isKiller)
end
