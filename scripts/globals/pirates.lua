-----------------------------------
-- Ship bound for [Mhaura/Selbina] Pirates helpers
-- NOTE: Careful with queues as they don't resolve until a zone wakes from sleep, potentially having mismatched timing. Timers are fine.
-----------------------------------

xi = xi or {}
xi.pirates = xi.pirates or {}

-- chance for encounter to have a special middle NPC, which indicates a chance for NM to spawn
local vermCloakPirateChance = 10

local actions =
{
    ARRIVING        = 0,
    ARRIVE          = 1,
    PIRATES_ARRIVE  = 2,
    MOBS_SPAWN      = 3,
    PIRATES_RETREAT = 4,
    DEPART          = 5,
    DEPARTING       = 6,
}

-- times are minutes after midnight for first cycle, cycle is 480 minutes
local piratesSchedule =
{
    { endTime = utils.timeStringToMinutes('01:10'), action = actions.ARRIVING },
    { endTime = utils.timeStringToMinutes('01:30'), action = actions.ARRIVE },
    { endTime = utils.timeStringToMinutes('01:32'), action = actions.PIRATES_ARRIVE },
    { endTime = utils.timeStringToMinutes('01:35'), action = actions.MOBS_SPAWN },
    { endTime = utils.timeStringToMinutes('04:20'), action = actions.PIRATES_RETREAT },
    { endTime = utils.timeStringToMinutes('04:27'), action = actions.DEPART },
    { endTime = utils.timeStringToMinutes('04:48'), action = actions.DEPARTING },
}

local piratesData =
{
    -- Pirate ship is on left side of boat
    [xi.zone.SHIP_BOUND_FOR_SELBINA_PIRATES] =
    {
        {
            startPos    = { x = -33.601, y = -7.16, z = 13.37, rotation = 0 },
            standingPos = { x =  -21.90, y = -7.16, z = 10.46, rotation = 0 },
        },
        {
            startPos    = { x = -29.728, y = -7.16, z = 1.30, rotation = 0 },
            standingPos = { x =  -21.90, y = -7.16, z = 6.59, rotation = 0 },
        },
        {
            startPos    = { x = -29.602, y = -7.16, z = -2.47, rotation = 0 },
            standingPos = { x =  -21.90, y = -7.16, z =  2.10, rotation = 0 },
        },
    },
    -- Pirate ship is on right side of boat
    [xi.zone.SHIP_BOUND_FOR_MHAURA_PIRATES] =
    {
        {
            startPos    = { x = 33.601, y = -7.16, z = 13.37, rotation = 128 },
            standingPos = { x =  21.90, y = -7.16, z = 10.46, rotation = 128 },
        },
        {
            startPos    = { x = 29.728, y = -7.16, z = 1.30, rotation = 128 },
            standingPos = { x =  21.90, y = -7.16, z = 6.59, rotation = 128 },
        },
        {
            startPos    = { x = 29.602, y = -7.16, z = -2.47, rotation = 128 },
            standingPos = { x =  21.90, y = -7.16, z =  2.10, rotation = 128 },
        },
    },
}

xi.pirates.setupPirateNPCSchedule = function(npc)
    npc:initNpcAi()

    -- create triggers for every stage of the encounter on each Pirate NPC
    for _, eventData in ipairs(piratesSchedule) do
        npc:addPeriodicTrigger(eventData.action, 480, eventData.endTime)
    end
end

-- calls itself via timer until the npc is hidden
local function summonAnimations(npc, rotation, offset)
    if npc:getStatus() == xi.status.DISAPPEAR then
        return
    end

    if not npc:isFollowingPath() then
        local pos = npc:getPos()
        if npc:getLocalVar('initialNpcState') == 1 then
            npc:setLocalVar('initialNpcState', 0)
            -- rotate to face the player boat
            npc:setPos(pos.x, pos.y, pos.z, rotation)
            -- first summoning rotation happens in order of NPC ID
            npc:setLocalVar('summonStartTime', GetSystemTime() + (offset - 1) * 2)
        end

        local summonStartTime = npc:getLocalVar('summonStartTime')
        if summonStartTime ~= 0 and summonStartTime <= GetSystemTime() then
            npc:setLocalVar('summonStartTime', 0)
            npc:setLocalVar('summonEndTime', GetSystemTime() + math.random(1, 2))

            npc:entityAnimationPacket(xi.animationString.CAST_SUMMONER_START)
        end

        local summonEndTime = npc:getLocalVar('summonEndTime')
        if summonEndTime ~= 0 and summonEndTime <= GetSystemTime() then
            npc:setLocalVar('summonEndTime', 0)
            -- npcs seem to wait anywhere from 5 to 10s to do another summoning animation
            npc:setLocalVar('summonStartTime', GetSystemTime() + math.random(4 + offset, 10))

            npc:entityAnimationPacket(xi.animationString.CAST_SUMMONER_STOP)
        end

        -- No more animations and npc is done pathing
        if summonEndTime == 0 and summonStartTime == 0 then
            npc:setStatus(xi.status.DISAPPEAR)
        end
    end

    if npc:getStatus() == xi.status.DISAPPEAR then
        return
    end

    -- check again in 1.2s (pirates summon animation can last from 1s to 2s)
    npc:timer(1200, function(npcArg)
        summonAnimations(npcArg, rotation, offset)
    end)
end

-- called on every NPC periodic trigger, which is mapped 1-1 to the schedule table, with triggerId == action
xi.pirates.pirateNPCTimeTrigger = function(npc, triggerId, zoneKey)
    local pirateZone = npc:getZone()
    if not pirateZone then
        return
    end

    local pirateNPCs = zones[pirateZone:getID()].npc.PIRATES
    local pirateIdx = 0
    for i, npcId in ipairs(pirateNPCs) do
        if npcId == npc:getID() then
            pirateIdx = i
            break
        end
    end

    local pirateData = piratesData[zoneKey][pirateIdx]
    if not pirateData then
        return
    end

    if triggerId == actions.PIRATES_ARRIVE then
        -- Pirates appear and run to position
        if pirateIdx == 2 then
            -- middle pirate has chance to wear a verm cloak, which then means the pirate encounter _might_ have the NM spawn
            local bodyModel = 8195
            local nmCanSpawn = 0
            if math.random(1, 100) <= vermCloakPirateChance then
                bodyModel = 47
                nmCanSpawn = 1
            end

            npc:setModelId(bodyModel, xi.slot.BODY)
            pirateZone:setLocalVar('nmCanSpawn', nmCanSpawn)
        end

        npc:setPos(pirateData.startPos)
        npc:setStatus(xi.status.NORMAL)
        npc:clearPath()
        npc:pathTo(pirateData.standingPos.x, pirateData.standingPos.y, pirateData.standingPos.z, xi.path.flag.RUN + xi.path.flag.WALLHACK)

        -- Indicates we need to rotate NPC after pathing completes
        npc:setLocalVar('initialNpcState', 1)
        summonAnimations(npc, pirateData.standingPos.rotation, pirateIdx)
    elseif triggerId == actions.PIRATES_RETREAT then
        -- retreat
        local summonEndTime = npc:getLocalVar('summonEndTime')
        -- No more animations will happen and recursive function self destructs
        npc:setLocalVar('summonStartTime', 0)
        npc:setLocalVar('summonEndTime', 0)
        if summonEndTime > 0 then
            npc:entityAnimationPacket(xi.animationString.CAST_SUMMONER_STOP)
        end

        npc:pathTo(pirateData.startPos.x, pirateData.startPos.y, pirateData.startPos.z, xi.path.flag.RUN + xi.path.flag.WALLHACK)
    elseif triggerId == actions.DEPART then
        -- Just in case summonAnimations didn't set status
        npc:clearPath()
        npc:setStatus(xi.status.DISAPPEAR)
    end

    xi.pirates.zoneStateChange(pirateZone, triggerId)
end

xi.pirates.zoneStateChange = function(zone, action)
    -- change the zone's state once per action cycle (this function is called by each NPC)
    if zone:getLocalVar('currPiratesAction') ~= action then
        zone:setLocalVar('currPiratesAction', action)

        if action == actions.MOBS_SPAWN then
            -- TODO enable mob spawns (and NM spawns if nmCanSpawn is set to 1)
            -- set them to setRespawn(1s), then set normal respawnTime in onMobSpawn
        elseif action == actions.PIRATES_RETREAT then
            -- TODO disable all spawns and despawn any not in combat
            -- mobs in combat do not despawn when the ship leaves
        end
    end
end
