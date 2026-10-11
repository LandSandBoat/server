-----------------------------------
-- Dark Rider
--
-- One run at a time across Wajaom Woodlands, Bhaflau Thickets, Mount Zhayolm and Caedarva Mire.
-- The rider appears at a route's start with six escorts posted along it, runs it in legs with a rest after each, and vanishes at the end.
-- A Warhorse Hoofprint is left at every rest but the last, usable once the rider is gone.
-----------------------------------
xi = xi or {}
xi.darkRider = xi.darkRider or {}

local runZones =
{
    xi.zone.WAJAOM_WOODLANDS,
    xi.zone.BHAFLAU_THICKETS,
    xi.zone.MOUNT_ZHAYOLM,
    xi.zone.CAEDARVA_MIRE,
}

local hoofprintCount = 3

local function scheduleRun(delayMin, delayMax)
    -- Time before zone, another process can read between the two writes
    SetServerVariable('DarkRider_PopTime', GetSystemTime() + math.randomInt(delayMin, delayMax) * 3600)
    SetServerVariable('DarkRider_ZoneID', utils.randomEntry(runZones))
end

xi.darkRider.onMobInitialize = function(mob)
    for _, immunity in pairs(xi.immunity) do
        mob:addImmunity(immunity)
    end
end

-- routes: list of { points = { { x, y, z }, ... }, posts = { six escort positions } }
xi.darkRider.onMobSpawn = function(mob, routes)
    mob:setMobMod(xi.mobMod.ROAM_COOL, 0)
    mob:setMobMod(xi.mobMod.ROAM_RESET_FACING, 0)
    mob:setMod(xi.mod.UDMGPHYS, -10000)
    mob:setMod(xi.mod.UDMGRANGE, -10000)
    mob:setMod(xi.mod.UDMGBREATH, -10000)
    mob:setMod(xi.mod.UDMGMAGIC, -10000)
    mob:setMod(xi.mod.UFASTCAST, 150)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 30)
    mob:setMobMod(xi.mobMod.MAGIC_DELAY, 30)

    local routeIndex = math.randomInt(1, #routes)
    local route      = routes[routeIndex]
    local start      = route.points[1]

    mob:setLocalVar('routeIndex', routeIndex)
    mob:setLocalVar('pointIndex', 1)
    mob:setPos(start.x, start.y, start.z)

    for offset, post in ipairs(route.posts) do
        local escortId = mob:getID() + offset
        local escort   = GetMobByID(escortId)

        if escort then
            escort:setSpawn(post.x, post.y, post.z)
            SpawnMob(escortId)
        end
    end
end

xi.darkRider.onMobRoamAction = function(mob, routes)
    local points   = routes[mob:getLocalVar('routeIndex')].points
    local position = mob:getPos()

    if utils.distance(position, points[#points], true) < 1 then
        DespawnMob(mob:getID())

        return
    end

    -- Closest point on the route ahead
    local index    = #points
    local nearest  = points[#points]
    local offRoute = math.huge

    for first = mob:getLocalVar('pointIndex'), #points - 1 do
        local from   = points[first]
        local to     = points[first + 1]
        local dx     = to.x - from.x
        local dz     = to.z - from.z
        local length = dx * dx + dz * dz
        local ratio  = 0

        if length > 0 then
            ratio = utils.clamp(((position.x - from.x) * dx + (position.z - from.z) * dz) / length, 0, 1)
        end

        local point    = { x = from.x + dx * ratio, y = from.y + (to.y - from.y) * ratio, z = from.z + dz * ratio }
        local distance = utils.distance(position, point, true)

        if distance < offRoute then
            index    = first + 1
            nearest  = point
            offRoute = distance
        end
    end

    -- Dragged off the route by a fight: walk back to it over the navmesh
    if offRoute > 2 then
        mob:pathTo(nearest.x, nearest.y, nearest.z)

        return
    end

    -- Leave a hoofprint where the rider just rested, unless a fight broke the leg
    if mob:getLocalVar('resting') == 1 then
        local placed    = mob:getLocalVar('hoofprints')
        local hoofprint = GetNPCByID(zones[mob:getZoneID()].npc.HOOFPRINT + placed % hoofprintCount)

        if hoofprint then
            hoofprint:setStatus(xi.status.DISAPPEAR)
            hoofprint:setPos(position.x, position.y, position.z)
        end

        mob:setLocalVar('hoofprints', placed + 1)
    end

    -- Run on along the route until the leg's distance is spent
    local leg       = {}
    local from      = position
    local remaining = math.randomInt(150, 200)

    mob:setLocalVar('pointIndex', index - 1)

    while index <= #points do
        local to   = points[index]
        local step = utils.distance(from, to, true)

        -- Stop partway along this stretch, unless that would leave less than a yalm to the end
        if step > remaining and (index < #points or step - remaining >= 1) then
            local ratio = remaining / step

            table.insert(leg, { x = from.x + (to.x - from.x) * ratio, y = from.y + (to.y - from.y) * ratio, z = from.z + (to.z - from.z) * ratio })

            break
        end

        table.insert(leg, to)
        remaining = remaining - step
        from      = to
        index     = index + 1
    end

    -- The last rest before vanishing is always the same length
    local rest = 12
    if index <= #points then
        rest = math.randomInt(6, 11)
    end

    local stop = leg[#leg]
    leg[#leg]  = { x = stop.x, y = stop.y, z = stop.z, wait = rest * 1000 }

    mob:setLocalVar('resting', 1)
    mob:pathThrough(leg, bit.bor(xi.pathflag.COORDS, xi.pathflag.RUN, xi.pathflag.SCRIPT))
end

xi.darkRider.onMobEngage = function(mob, target)
    mob:setLocalVar('resting', 0)
end

xi.darkRider.onMobDespawn = function(mob, routes)
    local firstHoofprint = zones[mob:getZoneID()].npc.HOOFPRINT

    for offset = 0, math.min(mob:getLocalVar('hoofprints'), hoofprintCount) - 1 do
        local hoofprint = GetNPCByID(firstHoofprint + offset)
        if hoofprint then
            hoofprint:setStatus(xi.status.NORMAL)
        end
    end

    for offset = 1, #routes[mob:getLocalVar('routeIndex')].posts do
        local escort = GetMobByID(mob:getID() + offset)
        if escort and escort:isSpawned() then
            escort:timer(5000, function(escortArg)
                DespawnMob(escortArg:getID())
            end)
        end
    end

    scheduleRun(60, 72)
end

-- Hoofprints do not survive a restart
-- Only the first zone to start reschedules
xi.darkRider.onZoneInitialize = function()
    local popTime = GetServerVariable('DarkRider_PopTime')

    if popTime == 0 or popTime > GetSystemTime() + 3 * 3600 then
        scheduleRun(1, 3)
    end
end

xi.darkRider.onGameHour = function(zone)
    local ID          = zones[zone:getID()]
    local currentTime = GetSystemTime()
    local popTime     = GetServerVariable('DarkRider_PopTime')

    local active = {}
    for offset = 0, hoofprintCount - 1 do
        local hoofprint = GetNPCByID(ID.npc.HOOFPRINT + offset)
        if hoofprint and hoofprint:getStatus() == xi.status.NORMAL then
            table.insert(active, hoofprint)
        end
    end

    -- One roll an hour over the 12 hours before the next run, each able to switch one hoofprint off
    -- Any still left go when the run starts
    local hoursLeft = math.max(math.ceil((popTime - currentTime) / 3600), 0)
    if hoursLeft == 0 then
        for _, hoofprint in ipairs(active) do
            hoofprint:setStatus(xi.status.DISAPPEAR)
        end
    elseif
        hoursLeft <= 12 and
        hoursLeft < zone:getLocalVar('hoofprintRoll') and
        #active > 0 and
        math.randomInt(1, 5) == 1
    then
        utils.randomEntry(active):setStatus(xi.status.DISAPPEAR)
    end

    zone:setLocalVar('hoofprintRoll', hoursLeft)

    local rider = GetMobByID(ID.mob.DARK_RIDER)
    if
        GetServerVariable('DarkRider_ZoneID') == zone:getID() and
        currentTime >= popTime and
        rider and
        not rider:isSpawned()
    then
        SpawnMob(ID.mob.DARK_RIDER)
    end
end
