-----------------------------------
-- Area: Kuftal Tunnel
--   NM: Guivre
-----------------------------------
require("scripts/globals/pathfind")
-----------------------------------
local entity = {}

local pathStart =
{
    {x = 102.00, y = -0.19, z = 3.00}
}

local pathBranch1 =
{
    {x = 102.00, y = -0.19, z = 3.00},
    {x = 109.49, y = 0.59, z = -0.07},
    {x = 124.47, y = 0.00, z = -42.08},
    {x = 91.93, y = -5.15, z = -58.24},
    {x = 66.46, y = -8.81, z = -62.91},
    {x = 60.86, y = -9.02, z = -73.80},
    {x = 57.09, y = -9.37, z = -96.88},
    {x = 38.39, y = -8.62, z = -98.74},
    {x = 15.73, y = -1.02, z = -94.88},
    {x = -0.65, y = 0.00, z = -84.13}
}

local pathBranch2 =
{
    {x = -40.24, y = 0.00, z = -38.35},
    {x = -44.36, y = 0.68, z = 13.98}
}

local pathBranch3 =
{
    {x = -31.28, y = -0.23, z = 48.64},
    {x = -0.52, y = 0.00, z = 82.02}
}

local pathBranch4 =
{
    {x = 3.06, y = 0.15, z = 125.56},
    {x = 40.12, y = 0.000, z = 158.89},
    {x = 60.35, y = -4.24, z = 143.23},
    {x = 79.86, y = -8.75, z = 139.89},
    {x = 85.86, y = -8.82, z = 138.11},
    {x = 91.87, y = -8.83, z = 142.52},
    {x = 101.60, y = -8.71, z = 143.17}
}

local pathBranch5 =
{
    {x = 100.62, y = -8.75, z = 78.86},
    {x = 108.29, y = -4.60, z = 54.26},
    {x = 118.98, y = 0.00, z = 38.12},
    {x = 102.00, y = -0.19, z = 3.00}
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
    --Guivre will despawn if not claimed within a 5 hours.
    local rndTime = math.random(3600, 18000)
    mob:setLocalVar("despawnTime", rndTime + os.time())
    mob:setLocalVar("isPaused", 0)
    mob:setLocalVar("mobPath", 0)
    mob:pathThrough(pathStart, xi.path.flag.COORDS)
end

entity.onPath = function(mob)
    if not mob:isFollowingPath() then
        if mob:getLocalVar("isPaused") ~= 0 then
            local currentPath = mob:getLocalVar("mobPath")
            local reversePath = mob:getLocalVar("reversePath")
            local path = {}
            mob:setLocalVar("isPaused", 0)
            mob:clearPath()
            if reversePath == 0 then --forward path logic begin
                switch (currentPath): caseof
                {
                    [0] = function()
                        local reverseCheck = math.random(0,2)
                        if reverseCheck == 0 then
                            mob:setLocalVar("reversePath", 0)
                            mob:setLocalVar("mobPath", 1)
                            path = pathBranch1
                            mob:pathThrough(path, xi.path.flag.COORDS)
                        else
                            mob:setLocalVar("reversePath", 1)
                            mob:setLocalVar("mobPath", 5)
                            path = pathBranch5
                            mob:pathThrough(path, bit.bor(xi.path.flag.COORDS, xi.path.flag.REVERSE))
                        end
                    end;
                    [1] = function()
                        mob:setLocalVar("mobPath", 2)
                        path = pathBranch2
                        mob:pathThrough(path, xi.path.flag.COORDS)
                    end;
                    [2] = function()
                        mob:setLocalVar("mobPath", 3)
                        path = pathBranch3
                        mob:pathThrough(path, xi.path.flag.COORDS)
                    end;
                    [3] = function()
                        mob:setLocalVar("mobPath", 4)
                        path = pathBranch4
                        mob:pathThrough(path, xi.path.flag.COORDS)
                    end;
                    [4] = function()
                        local reverseCheck = math.random(0,2)
                        if reverseCheck == 0 then
                            mob:setLocalVar("reversePath", 0)
                            mob:setLocalVar("mobPath", 5)
                            path = pathBranch5
                            mob:pathThrough(path, xi.path.flag.COORDS)
                        else
                            mob:setLocalVar("reversePath", 1)
                            mob:setLocalVar("mobPath", 4)
                            path = pathBranch4
                            mob:pathThrough(path, bit.bor(xi.path.flag.COORDS, xi.path.flag.REVERSE))
                        end
                    end;
                    [5] = function()
                        mob:setLocalVar("mobPath", 0)
                        path = pathStart
                        mob:pathThrough(path, xi.path.flag.COORDS)
                    end;
                }
            else --reverse path logic begin
                switch (currentPath): caseof
                {
                    [0] = function()
                        local reverseCheck = math.random(0,2)
                        if reverseCheck == 0 then
                            mob:setLocalVar("reversePath", 0)
                            mob:setLocalVar("mobPath", 1)
                            path = pathBranch1
                            mob:pathThrough(path, xi.path.flag.COORDS)
                        else
                            mob:setLocalVar("reversePath", 1)
                            mob:setLocalVar("mobPath", 5)
                            path = pathBranch5
                            mob:pathThrough(path, bit.bor(xi.path.flag.COORDS, xi.path.flag.REVERSE))
                        end
                    end;
                    [5] = function()
                        mob:setLocalVar("mobPath", 4)
                        path = pathBranch4
                        mob:pathThrough(path, bit.bor(xi.path.flag.COORDS, xi.path.flag.REVERSE))
                    end;
                    [4] = function()
                        mob:setLocalVar("mobPath", 3)
                        path = pathBranch3
                        mob:pathThrough(path, bit.bor(xi.path.flag.COORDS, xi.path.flag.REVERSE))
                    end;
                    [3] = function()
                        local reverseCheck = math.random(0,2)
                        if reverseCheck == 0 then
                            mob:setLocalVar("reversePath", 0)
                            mob:setLocalVar("mobPath", 3)
                            path = pathBranch3
                            mob:pathThrough(path, xi.path.flag.COORDS)
                        else
                            mob:setLocalVar("reversePath", 1)
                            mob:setLocalVar("mobPath", 2)
                            path = pathBranch2
                            mob:pathThrough(path, bit.bor(xi.path.flag.COORDS, xi.path.flag.REVERSE))
                        end
                    end;
                    [2] = function()
                        mob:setLocalVar("mobPath", 1)
                        path = pathBranch1
                        mob:pathThrough(path, bit.bor(xi.path.flag.COORDS, xi.path.flag.REVERSE))
                    end;
                    [1] = function()
                        mob:setLocalVar("mobPath", 0)
                        path = pathStart
                        mob:pathThrough(path, bit.bor(xi.path.flag.COORDS, xi.path.flag.REVERSE))
                    end;
                }
            end
        else
            --Guivre is paused, he will wait and rotate
            --a random amount of times before resuming his path
            mob:clearPath()
            local x = mob:getXPos()
            local y = mob:getYPos()
            local z = mob:getZPos()
            local rotations = {}
            local count = math.random(0,6)
            for i = 0, count do
                local wait = math.random(1500,3000)
                rotations[i+1] = {
                x = x, y = y, z = z, rotation = math.random(0,255),
                wait = wait }
            end
            mob:timer(math.random(1500, 3000), function(mob)
                mob:pathThrough(rotations, xi.path.flag.COORDS)
                mob:setLocalVar("isPaused", 1)
            end)
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
