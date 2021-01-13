-----------------------------------
-- Area: Lufaise Meadows
--  Mob: Colorful Leshy
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setLocalVar("timeToGrow", os.time() + math.random(43200, 86400)) -- Colorful in 12 to 24 hours
end

function disturbMob(mob)
    GetMobByID(mob:getID() + 1):setLocalVar("timeToGrow", os.time() + math.random(43200, 86400)) -- Defoliate in 12 to 24 hours
end

function onMobSpawn(mob)
    disturbMob(mob)
end

function onMobEngaged(mob, target)
    disturbMob(mob)
end

entity.onMobFight = function(mob, target)
    disturbMob(mob)
end

entity.onMobRoam = function(mob)
    local ph = mob:getID()
    local nm = GetMobByID(ph + 1)
    if (not nm:isSpawned() and os.time() > nm:getLocalVar("timeToGrow")) then
        local phIndex = mob:getLocalVar("phIndex")
        local p = mob:getPos()
        DisallowRespawn(ph, true)
        mob:setLocalVar("phIndex", 0)
        DespawnMob(ph)

        DisallowRespawn(ph + 1, false)
        nm:setSpawn(p.x, p.y, p.z, p.rot)
        SpawnMob(ph + 1)
        nm:setLocalVar("phIndex", phIndex)
    end
end

entity.onMobDeath = function(mob, player, isKiller)
end

function onMobDespawn(mob)
    local phIndex = mob:getLocalVar("phIndex")
    if (phIndex ~= 0) then
        mob:setLocalVar("phIndex", 0)
        DisallowRespawn(mob:getID(), true)
        DisallowRespawn(phIndex, false)
        GetMobByID(phIndex):setRespawnTime(GetMobRespawnTime(phIndex))
        mob:setLocalVar("timeToGrow", os.time() + math.random(3200, 86400)) -- Colorful in 12 to 24 hours
    end
end

return entity
