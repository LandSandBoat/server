-----------------------------------
-- Area: Ranguemont Pass
--  Mob: Taisai
-----------------------------------
local ID = require("scripts/zones/Ranguemont_Pass/IDs")

function disturbMob(mob)
    local phIndex = mob:getLocalVar("phIndex")
    if (phIndex > 0) then
        mob:setLocalVar("timeToGrow", os.time() + math.random(86400, 259200)) -- 1 to 3 days
    end
end

function onMobSpawn(mob)
    disturbMob(mob)
end

function onMobEngaged(mob, target)
    disturbMob(mob)
end

function onMobFight(mob, target)
    disturbMob(mob)
end

function onMobRoam(mob)
    -- if PH hasn't been disturbed, spawn NM
    local phIndex = mob:getLocalVar("phIndex")
    if (phIndex > 0 and os.time() > mob:getLocalVar("timeToGrow")) then
        mob:setLocalVar("phIndex", 0)
        local nm = GetMobByID(ID.mob.TAISAIJIN)
        DisallowRespawn(mob:getID(), true)
        DespawnMob(mob:getID())
        DisallowRespawn(nm:getID(), false)
        SpawnMob(nm:getID())
        nm:setLocalVar("phIndex", phIndex)
    end
end

function onMobDeath(mob, player, isKiller)
end
