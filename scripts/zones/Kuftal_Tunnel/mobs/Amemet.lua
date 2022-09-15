---------------------------------
--  Area: Kuftal Tunnel
--  NM: Amemet
---------------------------------
require("scripts/globals/hunts")
---------------------------------
local entity = {}

local pathNodesA =
{
    102, -0.191, 3,
    90.06, -0.28, 12.24,
    67.60, -0.34, 12.42,
    54.61, -4.11, 16.89,
    25.03, -9.28, 23.12,
    19.43, -7.95, 44.37,
    18.80, -6.63, 47.77,
    17.72, -5.14, 51.88,
    16.93, -3.95, 55.33,
    16.33, -3.09, 57.46,
    14.76, -1.78, 60.84,
    11.86, -0.60, 65.58,
    -0.52, 0.00, 82.02,
    3.06, 0.15, 125.56,
    40.12, 0.000, 158.89,
    60.35, -4.24, 143.23,
    79.86, -8.75, 139.89,
    85.86, -8.82, 138.11,
    91.87, -8.83, 142.52,
    101.60, -8.71, 143.17,
    100.62, -8.75, 78.86,
    108.29, -4.60, 54.26,
    118.98, 0.00, 38.12,
    102.61, 0.92, 1.60,
    102, -0.191, 3,
    102, -0.191, 3
}

local pathNodesB =
{
    102, -0.191, 3,
    109.49, 0.59, -0.07,
    124.47, 0.00, -42.08,
    91.93, -5.15, -58.24,
    66.46, -8.81, -62.91,
    60.86, -9.02, -73.80,
    57.09, -9.37, -96.88,
    38.39, -8.62, -98.74,
    15.73, -1.02, -94.88,
    -0.65, 0.00, -84.13,
    -40.24, 0.00, -38.35,
    -44.36, 0.68, 13.98,
    -31.28, -0.23, 48.64,
    -0.52, 0.00, 82.02,
    3.06, 0.15, 125.56,
    40.12, 0.000, 158.89,
    60.35, -4.24, 143.23,
    79.86, -8.75, 139.89,
    85.86, -8.82, 138.11,
    91.87, -8.83, 142.52,
    101.60, -8.71, 143.17,
    100.62, -8.75, 78.86,
    108.29, -4.60, 54.26,
    118.98, 0.00, 38.12,
    102.61, 0.92, 1.60,
    102, -0.191, 3,
    102, -0.191, 3
}


entity.onPath = function(mob)
    --Mob is on path node, let's check which path we need to route them to
    local currentPath = mob:getLocalVar("mobPath")
    local nextIndex = mob:getLocalVar("nextPatrolIndex")
    local reverseCheck = mob:getLocalVar("pathReverse")
    local pauseTime = mob:getLocalVar("pauseTime")
    if pauseTime < os.time() then
        if currentPath == 1 and reverseCheck == 0 then
            --Let's check if the mob is at one of the pre-determined pause points.
            if mob:atPoint({25.03, -9.28, 23.12}) or mob:atPoint({-0.52, 0.00, 82.02})
            or mob:atPoint({40.12, 0.000, 158.89}) or mob:atPoint({101.60, -8.71, 143.17}) then
                -- Pause check! Let's give it a 1 in 3 chance to pause.
                local pauseCheck = math.random(0,2)
                if pauseCheck == 2 then
                    local newPauseTime = math.random(15, 65) + os.time()
                    mob:setLocalVar("pauseTime", newPauseTime)
                    mob:setLocalVar("nextPatrolIndex", nextIndex + 1)
                    mob:setMobMod(xi.mobMod.NO_MOVE, 1)
                    return
                end
            end
            xi.path.patrol(mob, pathNodesA)
        elseif currentPath == 2 and reverseCheck == 0 then
            if mob:atPoint({57.09, -9.37, -96.88}) or mob:atPoint({-0.65, 0.00, -84.13})
            or mob:atPoint({-40.24, 0.00, -38.35}) or mob:atPoint({-44.36, 0.68, 13.98})
            or mob:atPoint({-0.52, 0.00, 82.02}) or mob:atPoint({40.12, 0.000, 158.89})
            or mob:atPoint({101.60, -8.71, 143.17}) then
                local pauseCheck = math.random(0,2)
                if pauseCheck == 2 then
                    local newPauseTime = math.random(15, 65) + os.time()
                    mob:setLocalVar("pauseTime", newPauseTime)
                    mob:setLocalVar("nextPatrolIndex", nextIndex + 1)
                    mob:setMobMod(xi.mobMod.NO_MOVE, 1)
                    return
                end
            end
            xi.path.patrol(mob, pathNodesB)
        elseif currentPath == 1 and reverseCheck == 1 then
            if mob:atPoint({25.03, -9.28, 23.12}) or mob:atPoint({-0.52, 0.00, 82.02})
            or mob:atPoint({40.12, 0.000, 158.89}) or mob:atPoint({101.60, -8.71, 143.17}) then
                local pauseCheck = math.random(0,2)
                if pauseCheck == 2 then
                    local newPauseTime = math.random(15, 65) + os.time()
                    mob:setLocalVar("pauseTime", newPauseTime)
                    mob:setLocalVar("nextPatrolIndex", nextIndex + 1)
                    mob:setMobMod(xi.mobMod.NO_MOVE, 1)
                    return
                end
            end
            xi.path.patrol(mob, xi.path.fromEnd(pathNodesA, 1))
        elseif currentPath == 2 and reverseCheck == 1 then
            if mob:atPoint({57.09, -9.37, -96.88}) or mob:atPoint({-0.65, 0.00, -84.13})
            or mob:atPoint({-40.24, 0.00, -38.35}) or mob:atPoint({-44.36, 0.68, 13.98})
            or mob:atPoint({-0.52, 0.00, 82.02}) or mob:atPoint({40.12, 0.000, 158.89})
            or mob:atPoint({101.60, -8.71, 143.17}) then
                local pauseCheck = math.random(0,2)
                if pauseCheck == 2 then
                    local newPauseTime = math.random(15, 65) + os.time()
                    mob:setLocalVar("pauseTime", newPauseTime)
                    mob:setLocalVar("nextPatrolIndex", nextIndex + 1)
                    mob:setMobMod(xi.mobMod.NO_MOVE, 1)
                    return
                end
            end
            xi.path.patrol(mob, xi.path.fromEnd(pathNodesB, 1))
        end
    else
        xi.path.pathToNearest(mob, pathNodesA)
    end
end

entity.onMobSpawn = function(mob)
    --Let's set a pauseTime for when/if mob pauses at a point.
    --Mob can pause anywhere from 15 to 60 seconds generally (don't quote me on that).
    --Since this is at spawn, let's set it a little shorter.
    --Let's first set a path to memory as well as if that path is to be
    --traversed in reverse or not.
    --Path choice can be A, B or to roam in general around spawn.
    --1: Path A
    --2: Path B
    mob:setLocalVar("pauseTime", math.random(8,15) + os.time())
    mob:setLocalVar("mobPath", math.random(1,2))
    mob:setLocalVar("pathReverse", math.random(0,1))
    --onMobRoam will fire next.
end

entity.onMobRoam = function(mob)
    -- First, let's check if mob is at spawn and needs a new path.
    local nextIndex = mob:getLocalVar("nextPatrolIndex")
    if nextIndex >= 24 and mob:atPoint({102, -0.191, 3}) then
        mob:setLocalVar("nextPatrolIndex", 2)
        entity.onMobSpawn(mob)
        return
    end
    --Next, let's check if mob is currently set to pause.
    local pauseCheck = mob:getLocalVar("pauseTime")
    if pauseCheck > os.time() then
        --Mob is currently set to pause and not move for the amount of pauseTime
        mob:setMobMod(xi.mobMod.NO_MOVE, 1)
        return
    else
        mob:setMobMod(xi.mobMod.NO_MOVE, 0)
        local currentPath = mob:getLocalVar("mobPath")
        local reverseCheck = mob:getLocalVar("pathReverse")
        if currentPath == 1 and reverseCheck == 0 then
            xi.path.patrol(mob, pathNodesA)
            return
        elseif currentPath == 1 and reverseCheck == 1 then
            xi.path.patrol(mob,xi.path.fromEnd(pathNodesA))
            return
        elseif currentPath == 2 and reverseCheck == 0 then
            xi.path.patrol(mob, pathNodesB)
            return
        elseif currentPath == 1 and reverseCheck == 1 then
            xi.path.patrol(mob,xi.path.fromEnd(pathNodesB))
            return
        end
    end
    --Next, let's check if a mob is currently on a path.
    if mob:isFollowingPath() then
        --continue following the chosen path.
        xi.path.pathToNearest(mob, pathNodesA)
        entity.onPath(mob)
    else
        --if not on pause or on a path, let's check if around spawn
        local spawn = mob:getSpawnPos()
        if mob:atPoint(spawn.x, spawn.y, spawn.z) then
            entity.onMobSpawn(mob)
            local currentPath = mob:getLocalVar("mobPath")
            if currentPath == 1 then
                --mob is set to patrol Path A
                xi.path.pathToNearest(mob, pathNodesA)
                entity.onPath(mob)
            elseif currentPath == 2 then
                --mob is set to patrol Path B
                xi.path.pathToNearest(mob, pathNodesB)
                entity.onPath(mob)
            end
        end
    end
end

entity.onMobEngage = function(mob)
    mob:setMobMod(xi.mobMod.NO_MOVE, 0)
end

entity.onMobDisengage = function(mob)
    local pathCheck = mob:getLocalVar("mobPath")
    if pathCheck == 1 then
        xi.path.pathToNearest(mob, pathNodesA)
        entity.onPath(mob)
    elseif pathCheck == 2 then
        xi.path.pathToNearest(mob, pathNodesB)
        entity.onPath(mob)
    end
end

entity.onMobDeath = function(mob, player, isKiller)
    xi.hunts.checkHunt(mob, player, 418)
end

return entity
