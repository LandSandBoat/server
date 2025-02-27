-----------------------------------
-- Zone: Silver_Sea_route_to_Al_Zahbi
-----------------------------------
---@type TZone
local zoneObject = {}

zoneObject.onInitialize = function(zone)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    return cs
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
end

zoneObject.onTransportEvent = function(entity, transport)
    if entity:getObjType() == xi.objType.PC then
        entity:startEvent(1025)
--    elseif entity:getObjType() == xi.objType.NPC then
--    elseif entity:getObjType() == xi.objType.MOB then
    end
end

zoneObject.onEventUpdate = function(player, csid, option, npc)
end

zoneObject.onEventFinish = function(player, csid, option, npc)
    if csid == 1025 then
        player:setPos(0, 0, 0, 0, 50)
    end
end

return zoneObject
