-----------------------------------
-- Area: Kuftal Tunnel
--   NM: Guivre
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x = 119.000, y = -0.010, z = 38.000 },
    { x = 123.207, y = -0.053, z = 42.922 },
    { x = 120.383, y =  0.000, z = 40.616 },
    { x = 118.630, y =  0.000, z = 36.190 },
    { x = 120.113, y =  0.000, z = 42.753 },
    { x = 118.639, y =  0.000, z = 44.329 },
    { x = 126.750, y =  0.157, z = 38.197 },
    { x = 118.176, y =  0.000, z = 41.281 },
    { x = 117.715, y =  0.000, z = 42.771 },
    { x = 125.745, y =  0.153, z = 43.592 },
    { x = 117.301, y =  0.000, z = 37.857 },
    { x = 121.808, y = -0.335, z = 37.698 },
    { x = 120.305, y =  0.456, z = 47.930 },
    { x = 119.843, y =  0.000, z = 43.875 },
    { x = 119.017, y =  0.000, z = 41.751 },
    { x = 119.004, y = -0.024, z = 46.015 },
    { x = 118.943, y =  0.000, z = 45.094 },
    { x = 118.268, y =  0.000, z = 45.124 },
    { x = 123.692, y =  0.148, z = 32.912 },
    { x = 108.250, y =  0.000, z = 42.682 },
    { x = 119.776, y =  0.000, z = 46.150 },
    { x = 122.674, y =  0.000, z = 43.026 },
    { x = 121.791, y = -0.014, z = 44.083 },
    { x = 114.239, y =  0.500, z = 48.261 },
    { x = 120.815, y =  0.000, z = 44.872 },
    { x = 115.921, y =  0.000, z = 46.305 },
    { x = 126.259, y =  0.169, z = 44.267 },
    { x = 117.731, y =  0.000, z = 42.973 },
    { x = 108.739, y =  0.000, z = 44.866 },
    { x = 115.806, y =  0.000, z = 44.546 },
    { x = 115.318, y =  0.454, z = 47.922 },
    { x = 114.506, y =  0.298, z = 35.025 },
    { x = 116.488, y =  0.000, z = 39.791 },
    { x = 120.631, y =  0.000, z = 40.704 },
    { x = 111.700, y =  0.400, z = 41.242 },
    { x = 118.439, y =  0.500, z = 49.354 },
    { x = 125.677, y =  0.000, z = 38.359 },
    { x = 120.316, y =  0.000, z = 43.006 },
    { x = 116.828, y =  0.500, z = 48.119 },
    { x = 110.060, y =  0.102, z = 48.177 },
    { x = 117.279, y =  0.000, z = 45.420 },
    { x = 122.334, y =  0.000, z = 43.699 },
    { x = 113.413, y =  0.120, z = 41.195 },
    { x = 117.480, y =  0.000, z = 44.830 },
    { x = 114.122, y = -0.082, z = 39.204 },
    { x = 122.629, y =  0.000, z = 39.259 },
    { x = 112.704, y =  0.328, z = 49.251 },
    { x = 119.162, y =  0.000, z = 42.720 },
    { x = 119.488, y =  0.000, z = 34.978 },
    { x = 114.269, y =  0.500, z = 48.077 },
}

local pathStart =
{
    { x = 102.00, y = -0.19, z = 3.00 }
}

local pathBranch1 =
{
    { x = 102.00, y = -0.19, z =   3.00 },
    { x = 109.49, y =  0.59, z =  -0.07 },
    { x = 124.47, y =  0.00, z = -42.08 },
    { x =  91.93, y = -5.15, z = -58.24 },
    { x =  66.46, y = -8.81, z = -62.91 },
    { x =  60.86, y = -9.02, z = -73.80 },
    { x =  57.09, y = -9.37, z = -96.88 },
    { x =  38.39, y = -8.62, z = -98.74 },
    { x =  15.73, y = -1.02, z = -94.88 },
    { x =  -0.65, y =  0.00, z = -84.13 },
}

local pathBranch2 =
{
    { x = -40.24, y = 0.00, z = -38.35 },
    { x = -44.36, y = 0.68, z =  13.98 },
}

local pathBranch3 =
{
    { x = -31.28, y = -0.23, z = 48.64 },
    { x =  -0.52, y =  0.00, z = 82.02 },
}

local pathBranch4 =
{
    { x =   3.06, y =  0.15, z = 125.56 },
    { x =  40.12, y =  0.00, z = 158.89 },
    { x =  60.35, y = -4.24, z = 143.23 },
    { x =  79.86, y = -8.75, z = 139.89 },
    { x =  85.86, y = -8.82, z = 138.11 },
    { x =  91.87, y = -8.83, z = 142.52 },
    { x = 101.60, y = -8.71, z = 143.17 },
}

local pathBranch5 =
{
    { x = 100.62, y = -8.75, z = 78.86 },
    { x = 108.29, y = -4.60, z = 54.26 },
    { x = 118.98, y =  0.00, z = 38.12 },
    { x = 102.00, y = -0.19, z =  3.00 },
}

local pathFind =
{
    ['pathFind1'] = function(mob, reversePath)
        local pathNodes = {}
        if reversePath == 0 or reversePath == 1 then
            mob:setLocalVar('mobPath', 2)
            local reverseCheck = math.random(0, 2)
            if reverseCheck == 0 then
                mob:setLocalVar('reversePath', 0)
                pathNodes = pathBranch1
            else
                mob:setLocalVar('reversePath', 1)
                pathNodes = pathBranch5
            end
        end

        return pathNodes
    end,

    ['pathFind2'] = function(mob, reversePath)
        local pathNodes = pathBranch4
        mob:setLocalVar('mobPath', 3)
        if reversePath == 0 then
            pathNodes = pathBranch2
        end

        return pathNodes
    end,

    ['pathFind3'] = function(mob, reversePath)
        local pathNodes = {}
        mob:setLocalVar('mobPath', 4)
        if reversePath == 0 or reversePath == 1 then
            pathNodes = pathBranch3
        end

        return pathNodes
    end,

    ['pathFind4'] = function(mob, reversePath)
        local pathNodes = pathBranch4
        if reversePath == 0 then
            mob:setLocalVar('mobPath', 5)
        else
            local reverseCheck = math.random(0, 2)
            if reverseCheck == 0 then
                mob:setLocalVar('mobPath', 4)
                mob:setLocalVar('reversePath', 0)
                pathNodes = pathBranch3
            else
                mob:setLocalVar('mobPath', 5)
                mob:setLocalVar('reversePath', 1)
                pathNodes = pathBranch2
            end
        end

        return pathNodes
    end,

    ['pathFind5'] = function(mob, reversePath)
        local pathNodes = pathBranch1
        mob:setLocalVar('mobPath', 6)

        if reversePath == 0 then
            local reverseCheck = math.random(0, 2)
            if reverseCheck == 0 then
                mob:setLocalVar('mobPath', 6)
                mob:setLocalVar('reversePath', 0)
                pathNodes = pathBranch5
            else
                mob:setLocalVar('mobPath', 3)
                mob:setLocalVar('reversePath', 1)
                pathNodes = pathBranch4
            end
        end

        return pathNodes
    end,

    ['pathFind6'] = function(mob, reversePath)
        local pathNodes = {}
        if reversePath == 0 or reversePath == 1 then
            mob:setLocalVar('mobPath', 1)
            pathNodes = pathStart
        end

        return pathNodes
    end,
}

entity.onMobInitialize = function(mob)
    -- Guivre has increased movespeed, sight range with
    -- Natural double/triple attack.
    mob:setMod(xi.mobMod.RUN_SPEED_MULT, 300)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 25)
    mob:setMod(xi.mod.TRIPLE_ATTACK, 15)
    mob:setMobMod(xi.mobMod.SIGHT_RANGE, 30)
    mob:setMobMod(xi.mobMod.ALWAYS_AGGRO, 1)

    xi.mob.updateNMSpawnPoint(mob)
    mob:setRespawnTime(math.random(900, 10800))
end

entity.onMobSpawn = function(mob)
    -- Guivre will despawn if not claimed within 3-5 hours.
    mob:setLocalVar('despawnTime', math.random(10800, 18000) + GetSystemTime())
    mob:setLocalVar('isPaused', 0)
    mob:setLocalVar('mobPath', 1)
    mob:pathThrough(pathStart, xi.path.flag.COORDS)
end

entity.onPath = function(mob)
    if not mob:isFollowingPath() then
        if mob:getLocalVar('isPaused') ~= 0 then
            local currentPath = 'pathFind' .. mob:getLocalVar('mobPath')
            local reversePath = mob:getLocalVar('reversePath')

            mob:setLocalVar('isPaused', 0)
            mob:clearPath()

            local pathNodes = pathFind[currentPath](mob, reversePath)

            local newReverse = mob:getLocalVar('reversePath')
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
            mob:setLocalVar('isPaused', 1)
        end
    end
end

entity.onMobRoam = function(mob)
    local despawnCheck = mob:getLocalVar('despawnTime')
    if despawnCheck <= GetSystemTime() then
        DespawnMob(mob:getID())
    end
end

entity.onMobDespawn = function(mob)
    xi.mob.updateNMSpawnPoint(mob)
    mob:setRespawnTime(math.random(64800, 86400)) -- 18 to 24 hours
end

return entity
