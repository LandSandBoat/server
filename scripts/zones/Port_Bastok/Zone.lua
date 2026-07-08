-----------------------------------
-- Zone: Port_Bastok (236)
-----------------------------------
local ID = zones[xi.zone.PORT_BASTOK]
---@type TZone
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    zone:registerCuboidTriggerArea(1, -112, -3, -17, -96, 3, -3)     -- event COP
    zone:registerCuboidTriggerArea(2, 53.5, 5, -165.3, 66.5, 6, -72) -- drawbridge area
    xi.conquest.toggleRegionalNPCs(zone)

    -- Set drawbridge NPCs always relevant to clients
    local drawBridge1 = GetNPCByID(ID.npc.DRAWBRIDGE_1)
    local drawBridge2 = GetNPCByID(ID.npc.DRAWBRIDGE_2)
    local drawBridge3 = GetNPCByID(ID.npc.DRAWBRIDGE_3)

    if drawBridge1 then
        drawBridge1:setNpcAlwaysRelevant(true)
    end

    if drawBridge2 then
        drawBridge2:setNpcAlwaysRelevant(true)
    end

    if drawBridge3 then
        drawBridge3:setNpcAlwaysRelevant(true)
    end
end

zoneObject.onConquestUpdate = function(zone, updatetype, influence, owner, ranking, isConquestAlliance)
    xi.conquest.onConquestUpdate(zone, updatetype, influence, owner, ranking, isConquestAlliance)
end

zoneObject.onZoneIn = function(player, prevZone)
    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        if prevZone == xi.zone.BASTOK_JEUNO_AIRSHIP then
            player:setPos(-36.000, 7.000, -58.000, 194)
            return 73
        end
    end

    return xi.moghouse.onMoghouseZoneEvent(player, prevZone)
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
end

zoneObject.onTriggerAreaLeave = function(player, triggerArea)
end

zoneObject.onTransportEvent = function(player, prevZoneId, transportId)
    player:startEvent(71)
end

zoneObject.onEventUpdate = function(player, csid, option, npc)
end

zoneObject.onEventFinish = function(player, csid, option, npc)
    if csid == 71 then
        player:setPos(0, 0, 0, 0, 224)
    end
end

return zoneObject
