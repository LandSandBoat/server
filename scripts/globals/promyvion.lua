xi = xi or {}
xi.promyvion = xi.promyvion or {}

-----------------------------------
-- Local functions
-----------------------------------
local function maxFloor(ID)
    local m = 0

    for _, v in pairs(ID.mob.MEMORY_RECEPTACLES) do
        m = math.max(m, v[1])
    end

    return m
end

local function randomizeFloorExit(ID, floor)
    local streams = {}

    for _, v in pairs(ID.mob.MEMORY_RECEPTACLES) do
        if v[1] == floor then
            GetNPCByID(v[3]):setLocalVar('[promy]floorExit', 0)
            table.insert(streams, v[3])
        end
    end

    local exitStreamId = streams[math.random(#streams)]
    GetNPCByID(exitStreamId):setLocalVar('[promy]floorExit', 1)
end

-----------------------------------
-- Zone global functions
-----------------------------------
xi.promyvion.handlePortal = function(player, npcId, eventId)
    if
        player:getAnimation() == xi.anim.NONE and
        GetNPCByID(npcId):getAnimation() == xi.anim.OPEN_DOOR
    then
        player:startOptionalCutscene(eventId)
    end
end

xi.promyvion.initZone = function(zone)
    local ID = zones[zone:getID()]

    -- randomize floor exits
    for i = 1, maxFloor(ID) do
        randomizeFloorExit(ID, i)
    end
end

-----------------------------------
-- Stray global functions
-----------------------------------
xi.promyvion.strayOnMobSpawn = function(mob)
    -- Strays only use animation-sub 13 and 14.
    -- They, however, use diferent models and said model has a color set, each alligned to an element.
    -- TODO: Investigate elements depending on model and animation-sub.
    local animationSub = 13 + math.random(0, 1)

    mob:setAnimationSub(animationSub)
end

-----------------------------------
-- Memory Receptacle global functions
-----------------------------------
xi.promyvion.receptacleOnFight = function(mob, target)
    if os.time() > mob:getLocalVar('[promy]nextStray') then
        local ID = zones[mob:getZoneID()]
        local mobId = mob:getID()
        local numStrays = ID.mob.MEMORY_RECEPTACLES[mobId][2]

        for i = mobId + 1, mobId + numStrays do
            local stray = GetMobByID(i)
            if not stray:isSpawned() then
                mob:setLocalVar('[promy]nextStray', os.time() + 20)
                stray:spawn()
                stray:updateEnmity(target)
                break
            end
        end
    else
        mob:setAnimationSub(2)
    end
end

xi.promyvion.receptacleOnDeath = function(mob, optParams)
    if optParams.isKiller then
        local ID = zones[mob:getZoneID()]
        local mobId = mob:getID()
        local floor = ID.mob.MEMORY_RECEPTACLES[mobId][1]
        local streamId = ID.mob.MEMORY_RECEPTACLES[mobId][3]
        local stream = GetNPCByID(streamId)

        mob:setAnimationSub(0)

        -- open floor exit portal
        if stream:getLocalVar('[promy]floorExit') == 1 then
            randomizeFloorExit(ID, floor)
            local events = ID.npc.MEMORY_STREAMS[streamId][7]
            local event = events[math.random(#events)]
            stream:setLocalVar('[promy]destination', event)
            stream:openDoor(180)
        end
    end
end
