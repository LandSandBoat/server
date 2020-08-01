-----------------------------------
-- Area: Boneyard_Gully
--  Mob: Shikaree X
-----------------------------------

function onMobEngaged(mob, target)
    SpawnMob(mob:getID() + 2)
end

function onMobDeath(mob, player, isKiller)
end
