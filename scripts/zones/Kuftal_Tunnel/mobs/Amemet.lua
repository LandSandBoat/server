---------------------------------
--  Area: Kuftal Tunnel
--  NM: Amemet
---------------------------------
require("scripts/globals/hunts")
---------------------------------
local entity = {}

local pathStart =
{
    { x = 102.61, y = 0.92, z = 1.60 },
}

local pathA =
{
    { x = 102.61, y = 0.92, z = 1.60 },
    { x = 90.06, y = -0.28, z = 12.24 },
    { x = 67.60, y = -0.34, z = 12.42 },
    { x = 54.61, y = -4.11, z = 16.89 },
    { x = 25.03, y =  -9.28, z = 23.12 },
    { x = 19.43, y = -7.95, z = 44.37 },
    { x = 18.80, y = -6.63, z = 47.77 },
    { x = 17.72, y = -5.14, z = 51.88 },
    { x = 16.93, y = -3.95, z = 55.33 },
    { x = 16.33, y = -3.09, z = 57.46 },
    { x = 14.76, y = -1.78, z = 60.84 },
    { x = 11.86, y = -0.60, z = 65.58 },
    { x = -0.52, y = 0.00, z = 82.02 },
}

local pathAb =
{
    { x = 3.06, y = 0.15, z = 125.56 },
    { x = 40.12, y = 0.000, z = 158.89 },
    { x = 60.35, y = -4.24, z = 143.23 },
    { x = 79.86, y = -8.75, z = 139.89 },
    { x = 85.86, y = -8.82, z = 138.11 },
    { x = 91.87, y = -8.83, z = 142.52 },
    { x = 101.60, y = -8.71, z = 143.17 },
    { x = 100.62, y = -8.75, z = 78.86 },
    { x = 108.29, y = -4.60, z = 54.26 },
    { x = 118.98, y = 0.00, z = 38.12 },
    { x = 102.61, y = 0.92, z = 1.60 },
}

local pathB =
{
    { x = 102.61, y = 0.92, z = 1.60 },
    { x = 109.49, y = 0.59, z = -0.07 },
    { x = 124.47, y = 0.00, z = -42.08 },
    { x = 91.93, y = -5.15, z = -58.24 },
    { x = 66.46, y = -8.81, z = -62.91 },
    { x = 60.86, y = -9.02, z = -73.80 },
    { x = 57.09, y = -9.37, z = -96.88 },
    { x = 38.39, y = -8.62, z = -98.74 },
    { x = 15.73, y = -1.02, z = -94.88 },
    { x = -0.65, y = 0.00, z = -84.13 },
    { x = -40.24, y = 0.00, z = -38.35 },
    { x = -44.36, y = 0.68, z = 13.98 },
    { x = -31.28, y = -0.23, z = 48.64 },
    { x = -0.52, y = 0.00, z = 82.02 },
}

local pathBb =
{
    { x = 3.06, y = 0.15, z = 125.56 },
    { x = 40.12, y = 0.000, z = 158.89 },
    { x = 60.35, y = -4.24, z = 143.23 },
    { x = 79.86, y = -8.75, z = 139.89 },
    { x = 85.86, y = -8.82, z = 138.11 },
    { x = 91.87, y = -8.83, z = 142.52 },
    { x = 101.60, y = -8.71, z = 143.17 },
    { x = 100.62, y = -8.75, z = 78.86 },
    { x = 108.29, y = -4.60, z = 54.26 },
    { x = 118.98, y = 0.00, z = 38.12 },
    { x = 102.61, y = 0.92, z = 1.60 },
}

local pathFind =
{
    ['pathFind1'] = function(mob, reversePath)
        local pathNodes = {}
        if reversePath == 0 or reversePath == 1 then
            local pathRnd = math.random(0, 1)
            local reverseCheck = math.random(0, 2)
            if pathRnd == 1 then
                mob:setLocalVar("mobPath", 2)
                if reverseCheck ~= 2 then
                    mob:setLocalVar("reversePath", 0)
                    pathNodes = pathA
                else
                    mob:setLocalVar("reversePath", 1)
                    pathNodes = pathAb
                end
            else
                mob:setLocalVar("mobPath", 4)
                if reverseCheck ~= 2 then
                    mob:setLocalVar("reversePath", 0)
                    pathNodes = pathB
                else
                    mob:setLocalVar("reversePath", 1)
                    pathNodes = pathBb
                end
            end
        end

        return pathNodes
    end,

    ['pathFind2'] = function(mob, reversePath)
        local pathNodes = {}
        mob:setLocalVar("mobPath", 3)
        if reversePath == 0 then
            pathNodes = pathAb
        else
            pathNodes = pathA
        end

        return pathNodes
    end,

    ['pathFind3'] = function(mob, reversePath)
        local pathNodes = {}
        if reversePath == 0 or reversePath == 1 then
            mob:setLocalVar("mobPath", 1)
            pathNodes = pathStart
        end

        return pathNodes
    end,

    ['pathFind4'] = function(mob, reversePath)
        local pathNodes = {}
        mob:setLocalVar("mobPath", 3)
        if reversePath == 0 then
            pathNodes = pathBb
        else
            pathNodes = pathB
        end

        return pathNodes
    end,
}

entity.onMobSpawn = function(mob)
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
                mob:pathThrough(pathNodes, bit.bor(xi.path.flag.REVERSE, xi.path.flag.COORDS))
            end
        else
            -- Amemet has a chance to pause, if successful he will wait
            -- a random amount of time before resuming his path
            mob:clearPath()
            local x = mob:getXPos()
            local y = mob:getYPos()
            local z = mob:getZPos()
            local pauses = {}
            local pauseRnd = math.random(0, 2)
            if pauseRnd == 2 then
                local count = math.random(0, 6)
                for i = 0, count do
                    local wait = math.random(4000, 6000)
                    pauses[i + 1] =
                    {
                        x = x, y = y, z = z, wait = wait
                    }
                end
            else
                local count = 1
                for i = 0, count do
                    pauses[i + 1] =
                    {
                        x = x, y = y, z = z
                    }
                end
            end

            mob:pathThrough(pauses, xi.path.flag.COORDS)
            mob:setLocalVar("isPaused", 1)
        end
    end
end

entity.onMobFight = function(mob)
    -- At 25% HP or less, Amemet receives regain.
    if mob:getHPP() <= 25 then
        mob:setMod(xi.mod.REGAIN, 10)
    end
end

entity.onMobDisengage = function(mob)
    mob:setMod(xi.mod.REGAIN, 0)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 418)
end

return entity
