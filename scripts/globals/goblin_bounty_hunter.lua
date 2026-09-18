-----------------------------------
-- Goblin Bounty Hunter patrols
--
-- Each hunter runs a fixed route, one leg per stop point.
-- At a stop it either rests 5-10s or holds one tick and runs on.
-- Korroloka hunters instead turn a full circle on the spot at every stop, about 8 s.
-----------------------------------
xi = xi or {}
xi.goblinBountyHunter = xi.goblinBountyHunter or {}

local restMin   = 5
local restMax   = 10
local passHold  = 400
local spinSteps = 10

local function nearestPointIndex(mob, route)
    local bestIndex    = 1
    local bestDistance = math.huge

    for index, point in ipairs(route) do
        local distance = mob:checkDistance(point.x, point.y, point.z)
        if distance < bestDistance then
            bestIndex    = index
            bestDistance = distance
        end
    end

    return bestIndex
end

-- Closed loop of { x, y, z, stop } points
-- Spin turns a full circle at every stop instead of resting
xi.goblinBountyHunter.patrol = function(mob, route, spin)
    -- Route point the last leg ended on, 0 before the first leg
    local index = mob:getLocalVar('patrolIndex')

    -- Off the route (spawn, combat): walk back to the closest route point over the navmesh
    if
        index == 0 or
        mob:checkDistance(route[index].x, route[index].y, route[index].z) > 2
    then
        index = nearestPointIndex(mob, route)
        mob:setLocalVar('patrolIndex', index)
        mob:pathTo(route[index].x, route[index].y, route[index].z)

        return
    end

    -- Corners up to the next stop point
    local points = {}

    index = index % #route + 1
    while not route[index].stop do
        table.insert(points, route[index])
        index = index % #route + 1
    end

    -- Korroloka: turn a full circle on the stop, one path point per step
    local stop = route[index]
    if spin then
        -- Start the circle from the heading the hunter arrives with
        local from    = points[#points] or { x = mob:getXPos(), z = mob:getZPos() }
        local heading = utils.getWorldRotation(from, stop)

        for step = 1, spinSteps do
            table.insert(points, { x = stop.x, y = stop.y, z = stop.z, rotation = math.floor(heading + step * 256 / spinSteps) % 256, wait = 1 })
        end
    else
        -- Everyone else: rest 5-10 s half the time, otherwise pause a tick and run on
        local wait = passHold
        if math.randomInt(1, 2) == 1 then
            wait = math.randomInt(restMin, restMax) * 1000
        end

        table.insert(points, { x = stop.x, y = stop.y, z = stop.z, wait = wait })
    end

    -- Remember where this leg ends and run it
    mob:setLocalVar('patrolIndex', index)
    mob:pathThrough(points, bit.bor(xi.pathflag.COORDS, xi.pathflag.RUN, xi.pathflag.SCRIPT))
end

xi.goblinBountyHunter.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.ROAM_COOL, 0)
    mob:setMobMod(xi.mobMod.ROAM_RESET_FACING, 0)
end
