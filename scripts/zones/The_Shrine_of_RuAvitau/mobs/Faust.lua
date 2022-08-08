-----------------------------------
-- Area: The Shrine of Ru'Avitau
--  Mob: Faust
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMod(xi.mod.REGAIN, 1000)
    mob:setMod(xi.mod.MOVE, 100)
    mob:setMobMod(xi.mobMod.SIGHT_RANGE, 30)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.NO_MOVE, 1)
    mob:setLocalVar("moveTime", os.time() + 6)
end

entity.onMobEngaged = function(mob)
    mob:setMobMod(xi.mobMod.NO_MOVE, 0)
end

entity.onMobRoam = function(mob)
    local spawn = mob:getSpawnPos()
    local distance = mob:checkDistance(spawn.x,spawn.y,spawn.z)

    -- Faust doesn't move from spawn point and rotates every 4-10 seconds
    if distance < 3 then
        mob:setMobMod(xi.mobMod.NO_MOVE, 1)
        if os.time() > mob:getLocalVar("moveTime") then
            local newTime = math.random(3,10)
            mob:setLocalVar("moveTime", os.time() + newTime)
            if mob:getRotPos() == 255 then
                mob:setRotation(191)
            else
                mob:setRotation(255)
            end
        end
    else
        mob:pathTo(spawn.x,spawn.y,spawn.z)
    end
end

entity.onMobFight = function(mob, target)
    -- Doesn't seem to reliably remove in onMobEngaged
    if mob:getMobMod(xi.mobMod.NO_MOVE) > 0 then
        mob:setMobMod(xi.mobMod.NO_MOVE, 0)
    end
end

entity.onMobDisengage = function(mob)
    local spawn = mob:getSpawnPos()
    mob:pathTo(spawn.x,spawn.y,spawn.z)
end

entity.onMobDeath = function(mob, player, isKiller)
end

entity.onMobDespawn = function(mob)
    mob:setRespawnTime(math.random(10800, 21600)) -- respawn 3-6 hrs
end

return entity
