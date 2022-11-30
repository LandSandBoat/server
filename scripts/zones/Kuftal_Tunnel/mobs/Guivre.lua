-----------------------------------
-- Area: Kuftal Tunnel
--   NM: Guivre
-----------------------------------
require("scripts/globals/pathfind")
-----------------------------------
local entity = {}

local pathStart =
{
    { x = 102.00, y = -0.19, z = 3.00 }
}

local pathBranch1 =
{
    { x = 102.00, y = -0.19, z = 3.00 },
    { x = 109.49, y = 0.59, z = -0.07 },
    { x = 124.47, y = 0.00, z = -42.08 },
    { x = 91.93, y = -5.15, z = -58.24 },
    { x = 66.46, y = -8.81, z = -62.91 },
    { x = 60.86, y = -9.02, z = -73.80 },
    { x = 57.09, y = -9.37, z = -96.88 },
    { x = 38.39, y = -8.62, z = -98.74 },
    { x = 15.73, y = -1.02, z = -94.88 },
    { x = -0.65, y = 0.00, z = -84.13 },
}

local pathBranch2 =
{
    { x = -40.24, y = 0.00, z = -38.35 },
    { x = -44.36, y = 0.68, z = 13.98 },
}

local pathBranch3 =
{
    { x = -31.28, y = -0.23, z = 48.64 },
    { x = -0.52, y = 0.00, z = 82.02 },
}

local pathBranch4 =
{
    { x = 3.06, y = 0.15, z = 125.56 },
    { x = 40.12, y = 0.000, z = 158.89 },
    { x = 60.35, y = -4.24, z = 143.23 },
    { x = 79.86, y = -8.75, z = 139.89 },
    { x = 85.86, y = -8.82, z = 138.11 },
    { x = 91.87, y = -8.83, z = 142.52 },
    { x = 101.60, y = -8.71, z = 143.17 },
}

local pathBranch5 =
{
    { x = 100.62, y = -8.75, z = 78.86 },
    { x = 108.29, y = -4.60, z = 54.26 },
    { x = 118.98, y = 0.00, z = 38.12 },
    { x = 102.00, y = -0.19, z = 3.00 },
}

local pathFind =
{
    ['pathFind1'] = function(mob, reversePath)
        local pathNodes = {}
        if reversePath == 0 or reversePath == 1 then
            mob:setLocalVar("mobPath", 2)
            local reverseCheck = math.random(0, 2)
            if reverseCheck == 0 then
                mob:setLocalVar("reversePath", 0)
                pathNodes = pathBranch1
            else
                mob:setLocalVar("reversePath", 1)
                pathNodes = pathBranch5
            end

            return pathNodes
        end
    end,

    ['pathFind2'] = function(mob, reversePath)
        local pathNodes = {}
        mob:setLocalVar("mobPath", 3)
        if reversePath == 0 then
            pathNodes = pathBranch2
        else
            pathNodes = pathBranch4
        end

        return pathNodes
    end,

    ['pathFind3'] = function(mob, reversePath)
        local pathNodes = {}
        mob:setLocalVar("mobPath", 4)
        if reversePath == 0 or reversePath == 1 then
            pathNodes = pathBranch3
        end

        return pathNodes
    end,

    ['pathFind4'] = function(mob, reversePath)
        local pathNodes = {}
        if reversePath == 0 then
            mob:setLocalVar("mobPath", 5)
            pathNodes = pathBranch4
        else
            local reverseCheck = math.random(0, 2)
            if reverseCheck == 0 then
                mob:setLocalVar("mobPath", 4)
                mob:setLocalVar("reversePath", 0)
                pathNodes = pathBranch3
            else
                mob:setLocalVar("mobPath", 5)
                mob:setLocalVar("reversePath", 1)
                pathNodes = pathBranch2
            end
        end

        return pathNodes
    end,

    ['pathFind5'] = function(mob, reversePath)
        local pathNodes = {}
        if reversePath == 0 then
            local reverseCheck = math.random(0, 2)
            if reverseCheck == 0 then
                mob:setLocalVar("mobPath", 6)
                mob:setLocalVar("reversePath", 0)
                pathNodes = pathBranch5
            else
                mob:setLocalVar("mobPath", 3)
                mob:setLocalVar("reversePath", 1)
                pathNodes = pathBranch4
            end
        else
            mob:setLocalVar("mobPath", 6)
            pathNodes = pathBranch1
        end

        return pathNodes
    end,

    ['pathFind6'] = function(mob, reversePath)
        local pathNodes = {}
        if reversePath == 0 or reversePath == 1 then
            mob:setLocalVar("mobPath", 1)
            pathNodes = pathStart
        end

        return pathNodes
    end,
}

entity.onMobInitialize = function(mob)
    --Guivre has increased movespeed, sight range with
    --natural double/triple attack.
    mob:setMod(xi.mod.MOVE, 150)
    mob:setMobMod(xi.mobMod.SIGHT_RANGE, 30)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 25)
    mob:setMod(xi.mod.TRIPLE_ATTACK, 15)
end

entity.onMobSpawn = function(mob)
    --Guivre will despawn if not claimed within 3-5 hours.
    mob:setLocalVar("despawnTime", math.random(10800, 18000) + os.time())
    mob:setLocalVar("isPaused", 0)
    mob:setLocalVar("mobPath", 1)
    mob:pathThrough(pathStart, xi.path.flag.COORDS)
end

entity.onPath = function(mob)
    if not mob:isFollowingPath() then
        if mob:getLocalVar("isPaused") ~= 0 then
            local currentPath = "pathFind" .. mob:getLocalVar("mobPath")
            local reversePath = mob:getLocalVar("reversePath")
            local pathNodes = {}
            mob:setLocalVar("isPaused", 0)
            mob:clearPath()
            pathNodes = pathFind[currentPath](mob, reversePath)
            local newReverse = mob:getLocalVar("reversePath")
            if newReverse == 0 then
                mob:pathThrough(pathNodes, xi.path.flag.COORDS)
            else
                mob:pathThrough(pathNodes, bit.bor(xi.path.flag.COORDS, xi.path.flag.REVERSE))
            end
        else
            -- Guivre is paused, he will wait and rotate
            -- a random amount of times before resuming his path
            mob:clearPath()
            local x = mob:getXPos()
            local y = mob:getYPos()
            local z = mob:getZPos()
            local rotations = {}
            local count = math.random(2, 6)
            for i = 0, count do
                local wait = math.random(1500, 3000)
                rotations[i + 1] =
                {
                    x = x, y = y, z = z, rotation = math.random(0, 255), wait = wait
                }
            end

            mob:pathThrough(rotations, xi.path.flag.COORDS)
            mob:setLocalVar("isPaused", 1)
        end
    end
end

entity.onMobRoam = function(mob)
    local despawnCheck = mob:getLocalVar("despawnTime")
    if despawnCheck <= os.time() then
        DespawnMob(mob:getID())
    end
end

entity.onMobDespawn = function(mob)
    UpdateNMSpawnPoint(mob:getID())
    mob:setRespawnTime(math.random(64800, 86400)) -- 18 to 24 hours
end

return entity
