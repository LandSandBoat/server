-----------------------------------
-- Zone: Kazham (250)
-----------------------------------
---@type TZone
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    xi.chocobo.initZone(zone)
    xi.chocoboGame.clearRecord(zone)
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
        if prevZone == xi.zone.KAZHAM_JEUNO_AIRSHIP then
            cs = 10002
        end

        player:setPos(-4.000, -3.000, 14.000, 66)
    end

    return cs
end

zoneObject.onTransportEvent = function(player, transport)
    player:startEvent(10000)
end

zoneObject.onEventUpdate = function(player, csid, option, npc)
end

zoneObject.onEventFinish = function(player, csid, option, npc)
    if csid == 10000 then
        player:setPos(0, 0, 0, 0, 226)
    end
end

return zoneObject
