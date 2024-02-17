-----------------------------------
-- Area: Ranguemont Pass
--  Mob: Taisai
-----------------------------------
local ID = zones[xi.zone.RANGUEMONT_PASS]
-----------------------------------
local entity = {}

local function disturbMob(mob)
    local phIndex = mob:getLocalVar('phIndex')
    if phIndex > 0 then
        mob:setLocalVar('timeToGrow', os.time() + math.random(86400, 259200)) -- 1 to 3 days
    end
end

entity.onMobSpawn = function(mob)
    disturbMob(mob)
end

entity.onMobEngage = function(mob, target)
    disturbMob(mob)
end

entity.onMobFight = function(mob, target)
    disturbMob(mob)
end

entity.onMobRoam = function(mob)
    -- if PH hasn't been disturbed, spawn NM
    local phIndex = mob:getLocalVar('phIndex')
    if phIndex > 0 and os.time() > mob:getLocalVar('timeToGrow') then
        mob:setLocalVar('phIndex', 0)
        local nm = GetMobByID(ID.mob.TAISAIJIN)
        DisallowRespawn(mob:getID(), true)
        DespawnMob(mob:getID())
        DisallowRespawn(nm:getID(), false)
        SpawnMob(nm:getID())
        nm:setLocalVar('phIndex', phIndex)
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
