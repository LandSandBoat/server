-----------------------------------
-- Zone: Garlaige_Citadel (200)
-----------------------------------
local ID = zones[xi.zone.GARLAIGE_CITADEL]
-----------------------------------
---@type TZone
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    -- Banishing Gate #1
    zone:registerCuboidTriggerArea(1, -208.5, -1, 224.5, -206, 1, 227)
    zone:registerCuboidTriggerArea(2, -208.5, -1, 213, -206, 1, 215.5)
    zone:registerCuboidTriggerArea(3, -214, -1, 224.5, -211.5, 1, 227)
    zone:registerCuboidTriggerArea(4, -214, -1, 212, -211.5, 1, 215.5)

    -- Banishing Gate #2
    zone:registerCuboidTriggerArea(10,  -51.5, -1,  82,  -48.5, 1,  84.5)
    zone:registerCuboidTriggerArea(11, -151, -1,  82, -148.5, 1,  84.5)
    zone:registerCuboidTriggerArea(12,  -51.5, -1, 115.5,  -49.5, 1, 118)
    zone:registerCuboidTriggerArea(13, -151, -1, 115.5, -148.5, 1, 118)

    -- Banishing Gate #3
    zone:registerCuboidTriggerArea(19, -191.5, -1, 355.5, -188.5, 1, 358.5)
    zone:registerCuboidTriggerArea(20, -131.5, -1, 355.5, -129, 1, 358.5)
    zone:registerCuboidTriggerArea(21, -191.5, -1, 322, -188.5, 1, 324.5)
    zone:registerCuboidTriggerArea(22, -131.5, -1, 322, -129, 1, 324.5)

    UpdateNMSpawnPoint(ID.mob.OLD_TWO_WINGS)
    GetMobByID(ID.mob.OLD_TWO_WINGS):setRespawnTime(math.random(900, 10800))

    UpdateNMSpawnPoint(ID.mob.SKEWER_SAM)
    GetMobByID(ID.mob.SKEWER_SAM):setRespawnTime(math.random(900, 10800))

    UpdateNMSpawnPoint(ID.mob.SERKET)
    GetMobByID(ID.mob.SERKET):setRespawnTime(math.random(900, 10800))

    xi.treasure.initZone(zone)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        player:setPos(-380.035, -13.548, 398.032, 64)
    end

    return cs
end

zoneObject.onConquestUpdate = function(zone, updatetype, influence, owner, ranking, isConquestAlliance)
    xi.conquest.onConquestUpdate(zone, updatetype, influence, owner, ranking, isConquestAlliance)
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
    local triggerAreaID = triggerArea:getTriggerAreaID()
    local leverSet = math.floor(triggerAreaID / 9) -- The set of levers player is standing on (0, 1, 2)
    local gateId   = ID.npc.BANISHING_GATE_OFFSET + (9 * leverSet) -- The ID of the related gate
    local gate = GetNPCByID(gateId)

    -- Logic when standing on the lever.
    GetNPCByID(ID.npc.BANISHING_GATE_OFFSET + triggerAreaID):setAnimation(xi.anim.OPEN_DOOR)

    -- If all 4 levers of a set are down, open related gate for varying times
    if
        gate and
        GetNPCByID(gateId):getAnimation() == xi.anim.CLOSE_DOOR and -- Avoid spamming if already open
        GetNPCByID(gateId + 1):getAnimation() == xi.anim.OPEN_DOOR and
        GetNPCByID(gateId + 2):getAnimation() == xi.anim.OPEN_DOOR and
        GetNPCByID(gateId + 3):getAnimation() == xi.anim.OPEN_DOOR and
        GetNPCByID(gateId + 4):getAnimation() == xi.anim.OPEN_DOOR
    then
        -- Default open time is 30 seconds for gate 1
        local time = 30
        -- Open time is 45 seconds for gate 2
        if gateId == ID.npc.BANISHING_GATE_OFFSET + 9 then
            time = 45
        -- Open time is 60 seconds for gate 3
        elseif gateId == ID.npc.BANISHING_GATE_OFFSET + 18 then
            time = 60
        end

        gate:openDoor(time)

        for _, playerInZone in pairs(gate:getZone():getPlayers()) do
            playerInZone:messageText(playerInZone, ID.text.BANISHING_GATES + leverSet, 5)
        end

        gate:timer(1000 * time, function(gateArg)
            for _, playerInZone in pairs(gateArg:getZone():getPlayers()) do
                playerInZone:messageText(playerInZone, ID.text.BANISHING_GATES_CLOSING + leverSet, 5)
            end
        end)
    end
end

-- TODO: For onTriggerAreaEnter and onTriggerAreaLeave
-- Regularly, the levers will deactivate the moment you step down, so long as the related door is closed.
-- However, if a lever is activated while it's related door is open, the lever will remain activated until the door closes.

zoneObject.onTriggerAreaLeave = function(player, triggerArea)
    GetNPCByID(ID.npc.BANISHING_GATE_OFFSET + triggerArea:getTriggerAreaID()):setAnimation(xi.anim.CLOSE_DOOR)
end

zoneObject.onEventUpdate = function(player, csid, option, npc)
end

zoneObject.onEventFinish = function(player, csid, option, npc)
end

return zoneObject
