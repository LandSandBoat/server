-----------------------------------
-- Zone: Empyreal_Paradox
-----------------------------------
---@type TZone
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    zone:registerCuboidTriggerArea(1, 538, -2, -501,  542, 0, -497) -- to The Garden of Ru'hmet
end

zoneObject.onConquestUpdate = function(zone, updatetype, influence, owner, ranking, isConquestAlliance)
    xi.conquest.onConquestUpdate(zone, updatetype, influence, owner, ranking, isConquestAlliance)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        --player:setPos(502, 0, 500, 222) -- BC Area
        player:setPos(539, -1, -500, 69)
    end

    return cs
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
    if triggerArea:getTriggerAreaID() == 1 then
        player:startEvent(100)
    end
end

zoneObject.onTriggerAreaLeave = function(player, triggerArea)
end

zoneObject.onEventUpdate = function(player, csid, option, npc)
end

zoneObject.onEventFinish = function(player, csid, option, npc)
    if csid == 100 and option == 1 then
        player:setPos(-420, -1, 379.900, 62, 35)
    end
end

return zoneObject
