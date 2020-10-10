-----------------------------------
-- Area: Ilrusi Atoll (Extermination)
--  Mob: Carrion Toad
-----------------------------------

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
    local instance = mob:getInstance()
    local TOAD = GetMobByID(17002544, instance)
    local RAND = math.random(1, 5)

    if RAND == 1 and TOAD:getLocalVar("ToadSpawned") == 0 then
        SpawnMob(17002544, instance)
        TOAD:setLocalVar("ToadSpawned", 1)
    else
        instance:setProgress(instance:getProgress() + 1)
    end
end
