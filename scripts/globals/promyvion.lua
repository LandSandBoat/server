require("scripts/zones/Promyvion-Dem/IDs")
require("scripts/zones/Promyvion-Holla/IDs")
require("scripts/zones/Promyvion-Mea/IDs")
require("scripts/zones/Promyvion-Vahzl/IDs")
-----------------------------------

xi = xi or {}
xi.promyvion = xi.promyvion or {}

-----------------------------------
-- LOCAL FUNCTIONS
-----------------------------------

local function findMother(mob)
    local ID = zones[mob:getZoneID()]
    local mobId = mob:getID()
    local mother = 0
    for k, v in pairs(ID.mob.MEMORY_RECEPTACLES) do
        if k < mobId and k > mother then
            mother = k
        end
    end

    return mother
end

local function receptaclesAliveOnFloor(mob)
    local zoneReceptacles = zones[mob:getZoneID()].mob.MEMORY_RECEPTACLES
    local group           = zoneReceptacles[mob:getID()].group
    local mobId           = mob:getID()

    local receptaclesAlive = {}
    for id, receptacle in pairs(zoneReceptacles) do
        if group == receptacle.group then
            if
                id ~= mobId and -- Don't added itself to the list
                GetMobByID(id):isAlive()
            then
                table.insert(receptaclesAlive, id)
            end
        end
    end

    return receptaclesAlive
end

local function receptaclesInGroup(mob)
    local zoneReceptacles = zones[mob:getZoneID()].mob.MEMORY_RECEPTACLES
    local group           = zoneReceptacles[mob:getID()].group

    local receptaclesGroup = {}
    for id, receptacle in pairs(zoneReceptacles) do
        if group == receptacle.group then
            table.insert(receptaclesGroup, id)
        end
    end

    return receptaclesGroup
end

-----------------------------------
-- PUBLIC FUNCTIONS
-----------------------------------

xi.promyvion.initZone = function(zone)
    local streams = zones[zone:getID()].npc.MEMORY_STREAMS

    -- register teleporter trigger areas
    for id, stream in pairs(streams) do
        zone:registerTriggerArea(id, unpack(stream.triggerArea))
    end
end

xi.promyvion.strayOnSpawn = function(mob)
    local mother = GetMobByID(findMother(mob))

    if mother ~= nil and mother:isSpawned() then
        mob:setPos(mother:getXPos(), mother:getYPos() - 5, mother:getZPos())
        mother:setAnimationSub(1)
        mother:timer(1000, function(motherArg)
            if motherArg:isAlive() then
                motherArg:setAnimationSub(2)
            end
        end)
    end
end

xi.promyvion.receptacleOnFight = function(mob, target)
    if os.time() > mob:getLocalVar("[promy]nextStray") then
        local ID = zones[mob:getZoneID()]
        local mobId = mob:getID()
        local numStrays = ID.mob.MEMORY_RECEPTACLES[mobId].strays
        local count = 0

        for i = mobId + 1, mobId + numStrays do
            local stray = GetMobByID(i)
            if stray:isSpawned() then
                count = count + 1
                if
                    stray:getCurrentAction() == xi.act.ROAMING and
                    mob:checkDistance(stray) < 8
                then
                    stray:updateEnmity(target)
                end
            end
        end

        if count < numStrays then
            mob:setLocalVar("[promy]nextStray", os.time() + 20)
            for i = mobId + 1, mobId + numStrays do
                local stray = GetMobByID(i)
                if not stray:isSpawned() then
                    count = count + 1
                    stray:setSpawn(mob:getXPos(), mob:getYPos(), mob:getZPos())
                    SpawnMob(stray:getID()):updateEnmity(target)
                    break
                end
            end
        end
    end
end

xi.promyvion.receptacleIdle = function(mob)
    if os.time() > mob:getLocalVar("[promy]nextStray") then
        local mobId = mob:getID()
        local numStrays = zones[mob:getZoneID()].mob.MEMORY_RECEPTACLES[mobId].strays
        local count = 0

        for i = mobId + 1, mobId + numStrays do
            local stray = GetMobByID(i)
            if stray:isSpawned() then
                count = count + 1
            end
        end

        if count < numStrays then
            mob:setLocalVar("[promy]nextStray", os.time() + 300)
            for i = mobId + 1, mobId + numStrays do
                local stray = GetMobByID(i)
                if
                    stray ~= nil and
                    not stray:isSpawned()
                then
                    count = count + 1
                    SpawnMob(stray:getID()):setPos(mob:getXPos(), mob:getYPos(), mob:getZPos())
                    break
                end
            end
        else
            mob:setAnimationSub(2)
        end
    else
        mob:setAnimationSub(2)
    end
end

xi.promyvion.receptacleOnDeath = function(mob, optParams)
    if mob:getLocalVar("deathLogic") == 0 then
        local mobId             = mob:getID()
        local zoneReceptacles   = zones[mob:getZoneID()].mob.MEMORY_RECEPTACLES
        local floor             = zoneReceptacles[mobId].group
        local streamId          = zoneReceptacles[mobId].stream
        local receptacleStreams = zones[mob:getZoneID()].npc.MEMORY_STREAMS[streamId]
        local stream            = GetNPCByID(streamId)
        local alive             = receptaclesAliveOnFloor(mob)

        -- Memory receptacles do not respawn until all on current floor are killed
        DisallowRespawn(mobId, true)
        mob:setAnimationSub(2)

        -- Random chance to open a portal, unless there are none left
        local portalChance = 1 / (#alive + 1)

        if math.random() < portalChance then
            local zone   = mob:getZone()
            if zone:getLocalVar(string.format("[MR][%s]", floor)) ~= 1 then
                -- Only open the portal if no other portals in this group are open
                local events = receptacleStreams.destinations
                local event  = events[math.random(#events)]
                zone:setLocalVar(string.format("[MR][%s]", floor), 1)

                stream:setLocalVar("[promy]destination", event)
                stream:setLocalVar("zoneportal", floor)
                stream:openDoor(180)
                stream:timer(179000, function(s)
                    local mobFloor = s:getLocalVar("zoneportal")
                    s:getZone():setLocalVar(string.format("[MR][%s]", mobFloor), 0)
                end)
            end
        end

        -- Allow respawn if all receptacles on floor are dead
        if #alive == 0 then
            local floorReceptacles = receptaclesInGroup(mob)
            for _, receptacleId in pairs(floorReceptacles) do
                DisallowRespawn(receptacleId, false)
                local receptacle = GetMobByID(receptacleId)
                if receptacle ~= nil then
                    receptacle:setRespawnTime(300)
                end
            end
        end

        mob:setLocalVar("deathLogic", 1)
    end
end

xi.promyvion.onTriggerAreaEnter = function(player, triggerArea)
    if player:getAnimation() == 0 then
        local streams = zones[player:getZoneID()].npc.MEMORY_STREAMS
        local triggerAreaID = triggerArea:GetTriggerAreaID()
        local event = nil

        if triggerAreaID < 100 then
            event = streams[triggerAreaID].destinations[1]
        else
            local stream = GetNPCByID(triggerAreaID)
            if stream ~= nil and stream:getAnimation() == xi.anim.OPEN_DOOR then
                event = stream:getLocalVar("[promy]destination")
            end
        end

        if event ~= nil then
            player:startOptionalCutscene(event)
        end
    end
end
