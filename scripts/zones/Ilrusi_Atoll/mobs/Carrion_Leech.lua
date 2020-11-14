-----------------------------------
-- Area: Ilrusi Atoll (Extermination)
--  Mob: Carrion Leech
-----------------------------------

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
    local instance = mob:getInstance()
    local LEECH = GetMobByID(17002542, instance)
    local RAND = math.random(1, 5)

    if RAND == 1 and LEECH:getLocalVar("LeechSpawned") == 0 then
        SpawnMob(17002542, instance)
        LEECH:setLocalVar("LeechSpawned", 1)
    else
        instance:setProgress(instance:getProgress() + 1)
    end
end
