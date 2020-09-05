-----------------------------------
-- Area: Ilrusi Atoll (Extermination)
--  Mob: Carrion Crab
-----------------------------------

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
    local instance = mob:getInstance()
    local CRAB = instance:getEntity(bit.band(17002541, 0xFFF), tpz.objType.MOB)
    local RAND = math.random(1, 5)

    if RAND == 1 and CRAB:getLocalVar("CrabSpawned") == 0 then
        SpawnMob(17002541, instance)
        CRAB:setLocalVar("CrabSpawned", 1)
    else
        instance:setProgress(instance:getProgress() + 1)
    end
end
