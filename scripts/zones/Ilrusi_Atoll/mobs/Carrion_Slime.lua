-----------------------------------
-- Area: Ilrusi Atoll (Extermination)
--  Mob: Carrion Slime
-----------------------------------

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
    local instance = mob:getInstance()
    local SLIME = instance:getEntity(bit.band(17002543, 0xFFF), tpz.objType.MOB)
    local RAND = math.random(1, 5)

    if RAND == 1 and SLIME:getLocalVar("SlimeSpawned") == 0 then
        SpawnMob(17002543, instance)
        SLIME:setLocalVar("SlimeSpawned", 1)
    else
        instance:setProgress(instance:getProgress() + 1)
    end
end
